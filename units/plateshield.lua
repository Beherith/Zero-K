return { plateshield = {
  unitname                      = [[plateshield]],
  name                          = [[Shieldbot Plate]],
  description                   = [[Parallel Unit Production]],
  buildDistance                 = Shared.FACTORY_PLATE_RANGE,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[plateshield_aoplane.dds]],

  buildoptions                  = {
    [[shieldcon]],
    [[shieldscout]],
    [[shieldraid]],
    [[shieldskirm]],
    [[shieldassault]],
    [[shieldriot]],
    [[shieldfelon]],
    [[shieldarty]],
    [[shieldaa]],
    [[shieldbomb]],
    [[shieldshield]],
  },

  buildPic                      = [[plateshield.png]],
  canMove                       = true,
  canPatrol                     = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 8 -5]],
  collisionVolumeScales         = [[66 24 36]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 16 30]],
  selectionVolumeScales         = [[70 42 96]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
    sortName           = [[1]],
    modelradius        = [[50]],
    aimposoffset       = [[0 10 -25]],
    midposoffset       = [[0 0 -25]],
    solid_factory      = [[3]],
    default_spacing    = 4,
    unstick_help       = 1,
    cus_noflashlight   = 1,
    child_of_factory   = [[factoryshield]],
    buggeroff_offset   = 40,

    outline_x = 165,
    outline_y = 165,
    outline_yoff = 27.5,
  },

  explodeAs                     = [[FAC_PLATEEX]],
  footprintX                    = 5,
  footprintZ                    = 7,
  iconType                      = [[padwalker]],
  maxDamage                     = Shared.FACTORY_PLATE_HEALTH,
  maxSlope                      = 15,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  metalCost                     = Shared.FACTORY_PLATE_COST,
  moveState                     = 1,
  noAutoFire                    = false,
  objectName                    = [[plate_shield.s3o]],
  script                        = "plateshield.lua",
  selfDestructAs                = [[FAC_PLATEEX]],
  showNanoSpray                 = false,
  sightDistance                 = 273,
  useBuildingGroundDecal        = true,
  workerTime                    = Shared.FACTORY_BUILDPOWER,
  yardMap                       = [[ooooo ooooo ooooo yyyyy yyyyy yyyyy yyyyy]],

  featureDefs                   = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX           = 5,
      footprintZ           = 7,
      object           = [[plate_shield_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 5,
      footprintZ       = 7,
      object           = [[debris4x4a.s3o]],
    },

  },

} }
