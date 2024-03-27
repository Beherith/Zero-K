function widget:GetInfo()
	return {
		name = "Selected Units GL4",
		desc = "Draw selection markers under units",
		author = "Fiendicus Prime, Beherith, Floris",
		date = "2023-12-19",
		license = "GNU GPL, v2 or later",
		-- Somewhere between layer -40 and -30 GetUnitUnderCursor starts
		-- returning nil before GetUnitsInSelectionBox includes that unit.
		layer = -30,
		enabled = true,
	}
end

-- Configurable Parts:
local lineWidth, showOtherSelections, platterOpacity, outlineOpacity

---- GL4 Backend Stuff----
-- FIXME: Make VBOs into a table?
local selectionShader, hoverSelectionVBO, localSelectionVBO, otherSelectionVBO
local luaShaderDir                                          = "LuaUI/Widgets/Include/"

local hasBadCulling                                         = ((Platform.gpuVendor == "AMD" and Platform.osFamily == "Linux") == true)

-- Localize for speedups:
local spGetGameFrame                                        = Spring.GetGameFrame
local spGetGameState                                        = Spring.GetGameState
local spGetSelectedUnits                                    = Spring.GetSelectedUnits
local spGetUnitDefID                                        = Spring.GetUnitDefID
local spGetUnitIsDead                                       = Spring.GetUnitIsDead
local spGetUnitTeam                                         = Spring.GetUnitTeam
local spLoadCmdColorsConfig                                 = Spring.LoadCmdColorsConfig
local spValidUnitID                                         = Spring.ValidUnitID

local SafeWGCall                                            = function(fnName, param1)
	if fnName then return fnName(param1) else return nil end
end
local GetUnitUnderCursor                                    = function(onlySelectable)
	return SafeWGCall(WG.PreSelection_GetUnitUnderCursor, onlySelectable)
end
local GetUnitsInSelectionBox                                = function()
	return SafeWGCall(WG.PreSelection_GetUnitsInSelectionBox)
end
local IsSelectionBoxActive                                  = function()
	return SafeWGCall(WG.PreSelection_IsSelectionBoxActive)
end

local glStencilFunc                                         = gl.StencilFunc
local glStencilOp                                           = gl.StencilOp
local glStencilTest                                         = gl.StencilTest
local glStencilMask                                         = gl.StencilMask
local glColorMask                                           = gl.ColorMask
local glDepthTest                                           = gl.DepthTest
local glClear                                               = gl.Clear
local GL_ALWAYS                                             = GL.ALWAYS
local GL_NOTEQUAL                                           = GL.NOTEQUAL
local GL_KEEP                                               = 0x1E00 --GL.KEEP
local GL_STENCIL_BUFFER_BIT                                 = GL.STENCIL_BUFFER_BIT
local GL_REPLACE                                            = GL.REPLACE
local GL_POINTS                                             = GL.POINTS

local selUnits                                              = {}
local doUpdate, allySelUnits, hoverUnitID

local unitScale                                             = {}
local unitCanFly                                            = {}
local unitBuilding                                          = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	unitScale[unitDefID] = (8 * (unitDef.xsize ^ 2 + unitDef.zsize ^ 2) ^ 0.5) - 2.0
	if unitDef.canFly then
		unitCanFly[unitDefID] = true
		unitScale[unitDefID] = unitScale[unitDefID] * 0.7
	elseif unitDef.isBuilding or unitDef.isFactory or unitDef.speed == 0 then
		local platterOverlap = 1.0 -- To make sure there aren't rendering gaps between adjacent buildings.
		unitBuilding[unitDefID] = {
			unitDef.xsize * 8 + platterOverlap,
			unitDef.zsize * 8 + platterOverlap
		}
	end
end

local function AddSelected(unitID, unitTeam, vbo, animate)
	if spValidUnitID(unitID) ~= true or spGetUnitIsDead(unitID) == true then return end
	-- When paused we don't want to animate from initial size because that may look misaligned / bad
	local _, _, paused = spGetGameState()
	local gf = paused and -30 or spGetGameFrame()
	animate = animate and 1 or 0

	local unitDefID = spGetUnitDefID(unitID)
	if unitDefID == nil then return end -- these cant be selected

	local numVertices = 64

	local radius = unitScale[unitDefID]

	local width, length
	if unitCanFly[unitDefID] then
		numVertices = 3
		width = radius
		length = radius
	elseif unitBuilding[unitDefID] then
		numVertices = 4
		width = unitBuilding[unitDefID][1]
		length = unitBuilding[unitDefID][2]
	else
		width = radius
		length = radius
	end

	-- Make sure we move local selections back to other when deselecting
	if hoverSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(hoverSelectionVBO, unitID)
	end
	if localSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(localSelectionVBO, unitID)
	end
	if otherSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(otherSelectionVBO, unitID)
	end

	-- Add the new selection
	pushElementInstance(
		vbo, -- push into this Instance VBO Table
		{
			length, width, 0, 0,                      -- lengthwidthcornerheight
			unitTeam,                                 -- teamID
			numVertices,                              -- how many trianges should we make
			gf, animate, 0, 0,                        -- the gameFrame (for animations), whether to animate (for preselection) and unused parameters
			0, 1, 0, 1,                               -- These are our default UV atlas tranformations
			0, 0, 0, 0                                -- these are just padding zeros, that will get filled in
		},
		unitID,                                       -- this is the key inside the VBO TAble,
		true,                                         -- update existing element
		nil,                                          -- noupload, dont use unless you
		unitID                                        -- last one should be UNITID?
	)
end

local function RemoveSelected(unitID)
	doUpdate = true
	selUnits[unitID] = nil	
	if hoverSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(hoverSelectionVBO, unitID)
	end
	if localSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(localSelectionVBO, unitID)
	end
	if otherSelectionVBO.instanceIDtoIndex[unitID] then
		popElementInstance(otherSelectionVBO, unitID)
	end
end

local function FindPreselUnits()
	local preselection = {}
	if hoverUnitID then
		preselection[hoverUnitID] = true
	end
	for _, unitID in pairs(GetUnitsInSelectionBox() or {}) do
		preselection[unitID] = true
	end
	return preselection
end

-- Hide/show the default Spring selection boxes
local function UpdateCmdColorsConfig(isOn)
	WG.widgets_handling_selection = WG.widgets_handling_selection or 0
	WG.widgets_handling_selection = WG.widgets_handling_selection + (isOn and 1 or -1)
	if not isOn and WG.widgets_handling_selection > 0 then
		return
	end
	spLoadCmdColorsConfig('unitBox  0 1 0 ' .. (isOn and 0 or 1))
end

local function init()
	lineWidth = tonumber(options.linewidth.value) or 3.0
	showOtherSelections = options.showallselections.value
	platterOpacity = tonumber(options.platteropacity.value) or 0.2
	outlineOpacity = tonumber(options.outlineopacity.value) or 0.8
	doUpdate = true

	for unitID, _ in pairs(selUnits) do
		RemoveSelected(unitID)
	end

	local DPatUnit = VFS.Include(luaShaderDir .. "DrawPrimitiveAtUnit.lua")
	local InitDrawPrimitiveAtUnitShader = DPatUnit.InitDrawPrimitiveAtUnitShader
	local InitDrawPrimitiveAtUnitVBO = DPatUnit.InitDrawPrimitiveAtUnitVBO
	local shaderConfig = DPatUnit.shaderConfig
	shaderConfig.BILLBOARD = 0
	shaderConfig.ANIMATION = 1
	shaderConfig.INITIALSIZE = 0.90
	shaderConfig.GROWTHRATE = 10.0
	shaderConfig.HEIGHTOFFSET = 0
	shaderConfig.USETEXTURE = 0
	-- shaderConfig.POST_GEOMETRY = "gl_Position.z = (gl_Position.z) - 64.0 / gl_Position.w;"
	shaderConfig.POST_GEOMETRY = ""
	shaderConfig.POST_SHADING = "fragColor.rgba = vec4(g_color.rgb, texcolor.a * " .. platterOpacity .. " + texcolor.a * sign(addRadius) * " .. (outlineOpacity - platterOpacity) .. ");"
	selectionShader = InitDrawPrimitiveAtUnitShader(shaderConfig, "selectedUnits")
	hoverSelectionVBO = InitDrawPrimitiveAtUnitVBO("selectedUnits_hover")
	localSelectionVBO = InitDrawPrimitiveAtUnitVBO("selectedUnits_local")
	otherSelectionVBO = InitDrawPrimitiveAtUnitVBO("selectedUnits_other")

	return selectionShader ~= nil
end

options_path = 'Settings/Interface/Selection/Selected Units'
options_order = { 'showallselections', 'linewidth', 'platteropacity', 'outlineopacity' }
options = {
	showallselections = {
		name = 'Show Other Selections',
		desc = 'Show selections of other players',
		type = 'bool',
		value = 'true',
		OnChange = function(self)
			showOtherSelections = nil
			init()
		end,
	},
	linewidth = {
		name = 'Line Width',
		desc = '',
		type = 'radioButton',
		items = {
			{ name = 'Thin',     key = '1' },
			{ name = 'Standard', key = '2' },
			{ name = 'Thick', key = '3' },
		},
		value = '2',
		noHotkey = true,
		OnChange = function(self)
			lineWidth = nil
			init()
		end,
	},
	platteropacity = {
		name = 'Platter Opacity',
		desc = '',
		type = 'number',
		min = 0.0,
		max = 0.3,
		step = 0.1,
		def = 0.2,
		OnChange = function(self)
			platterOpacity = nil
			init()
		end,
	},
	outlineopacity = {
		name = 'Outline Opacity',
		desc = '',
		type = 'number',
		min = 0.6,
		max = 1.0,
		step = 0.2,
		def = 0.8,
		OnChange = function(self)
			outlineOpacity = nil
			init()
		end,
	}
}

local function drawSelection(vbo, preUnit)
	if vbo.usedElements == 0 then
		return
	end
	selectionShader:SetUniform("addRadius", 0)

	-- Draw platter
	glDepthTest(false)
	glColorMask(preUnit) -- Only draw in preUnit, stencil later
	vbo.VAO:DrawArrays(GL_POINTS, vbo.usedElements)

	-- Draw outlines
	glDepthTest(not preUnit) -- No depth check for world
	glColorMask(true)
	selectionShader:SetUniform("addRadius", lineWidth)
	vbo.VAO:DrawArrays(GL_POINTS, vbo.usedElements)
end

-- Callins

function widget:drawSelections(preUnit)
	if localSelectionVBO.usedElements == 0 and otherSelectionVBO.usedElements == 0 then
		return
	end

	if hasBadCulling then
		gl.Culling(false)
	end

	selectionShader:Activate()

	selectionShader:SetUniform("iconDistance", 99999) -- pass
	glStencilTest(true)                            --https://learnopengl.com/Advanced-OpenGL/Stencil-testing
	glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE)      -- Set The Stencil Buffer To 1 Where Draw Any Polygon		this to the shader
	glClear(GL_STENCIL_BUFFER_BIT)                 -- set stencil buffer to 0
	glStencilFunc(GL_NOTEQUAL, 1, 1)               -- use NOTEQUAL instead of ALWAYS to ensure that overlapping transparent fragments dont get written multiple times
	glStencilMask(1)

	-- Each selection priority is drawn in sequence.
	drawSelection(hoverSelectionVBO, preUnit)
	drawSelection(localSelectionVBO, preUnit)
	drawSelection(otherSelectionVBO, preUnit)

	selectionShader:Deactivate()

	-- This is the correct way to exit out of the stencil mode, to not break drawing of area commands:
	glStencilFunc(GL_ALWAYS, 1, 1)
	glStencilTest(false)
	glStencilMask(255)
	glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP)
	glClear(GL_STENCIL_BUFFER_BIT)
	-- All the above are needed :(
end

function widget:DrawWorldPreUnit()
	widget:drawSelections(true)
end

function widget:DrawWorld()
	widget:drawSelections(false)
end

function widget:SelectionChanged()
	doUpdate = true
end

local HOVER_SEL, LOCAL_SEL, OTHER_SEL = 1, 2, 3

function widget:Update(dt)
	local newHoverUnitID = GetUnitUnderCursor(false)
	doUpdate = doUpdate or newHoverUnitID ~= hoverUnitID
	hoverUnitID = newHoverUnitID

	-- TODO: Add a callin for when ally selections change?
	local newAllySelUnits = WG.allySelUnits
	doUpdate = doUpdate or newAllySelUnits ~= allySelUnits
	allySelUnits = newAllySelUnits

	doUpdate = doUpdate or IsSelectionBoxActive()

	if not doUpdate then
		return
	end

	doUpdate = false

	local newSelUnits = {}
	-- Hover selections
	for unitID, _ in pairs(FindPreselUnits()) do
		if selUnits[unitID] ~= HOVER_SEL then
			AddSelected(unitID, 254, hoverSelectionVBO, true)
			selUnits[unitID] = HOVER_SEL
		end
		newSelUnits[unitID] = true
	end
	-- Local selections
	for _, unitID in pairs(spGetSelectedUnits()) do
		if not newSelUnits[unitID] and not selUnits[unitID] ~= LOCAL_SEL then
			AddSelected(unitID, 255, localSelectionVBO, false)
			selUnits[unitID] = LOCAL_SEL
		end
		newSelUnits[unitID] = true
	end
	-- Ally/other selections
	if showOtherSelections then
		for unitID, _ in pairs(allySelUnits or {}) do
			if not newSelUnits[unitID] and not selUnits[unitID] ~= OTHER_SEL  then
				AddSelected(unitID, spGetUnitTeam(unitID), otherSelectionVBO, false)
				selUnits[unitID] = OTHER_SEL
			end
			newSelUnits[unitID] = true
		end
	end
	-- Clean up deselected units
	for unitID, _ in pairs(selUnits) do
		if not newSelUnits[unitID] then
			RemoveSelected(unitID)
		end
	end
end

function widget:UnitDestroyed()
	doUpdate = true
end

function widget:UnitGiven()
	doUpdate = true
end

function widget:UnitTaken()
	doUpdate = true
end

function widget:VisibleUnitsChanged()
	-- Only called on start/stop of api_unit_tracker
	init()
end

function widget:Initialize()
	if not gl.CreateShader or not init() then
		widgetHandler:RemoveWidget()
		return
	end
	UpdateCmdColorsConfig(true)
end

function widget:Shutdown()
	UpdateCmdColorsConfig(false)
end
