return { platetank = {
  name                          = [[Tank Plate]],
  description                   = [[Parallel Unit Production]],
  buildDistance                 = Shared.FACTORY_PLATE_RANGE,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 11,
  buildingGroundDecalSizeY      = 11,
  buildingGroundDecalType       = [[platetank_aoplane.dds]],

  buildoptions                  = {
    [[tankcon]],
    [[tankraid]],
    [[tankheavyraid]],
    [[tankriot]],
    [[tankassault]],
    [[tankheavyassault]],
    [[tankarty]],
    [[tankheavyarty]],
    [[tankaa]],
  },

  buildPic                      = [[platetank.png]],
  canMove                       = true,
  canPatrol                     = true,
  category                      = [[SINK UNARMED]],
  corpse                        = [[DEAD]],
  collisionVolumeOffsets        = [[0 10 4]],
  collisionVolumeScales         = [[72 24 38]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 2 35]],
  selectionVolumeScales         = [[80 40 120]],
  selectionVolumeType           = [[box]],

  customParams                  = {
    sortName           = [[6]],
    solid_factory      = [[4]],
    default_spacing    = 4,
    aimposoffset       = [[0 10 -35]],
    midposoffset       = [[0 0 -35]],
    modelradius        = [[50]],
    unstick_help       = 1,
    child_of_factory   = [[factorytank]],
    buggeroff_offset   = 45,

    outline_x = 165,
    outline_y = 165,
    outline_yoff = 27.5,
  },

  explodeAs                     = [[FAC_PLATEEX]],
  footprintX                    = 6,
  footprintZ                    = 8,
  iconType                      = [[padtank]],
  levelGround                   = false,
  maxDamage                     = Shared.FACTORY_PLATE_HEALTH,
  maxSlope                      = 15,
  maxWaterDepth                 = 0,
  metalCost                     = Shared.FACTORY_PLATE_COST,
  moveState                     = 1,
  noAutoFire                    = false,
  objectName                    = [[plate_tank.s3o]],
  script                        = [[platetank.lua]],
  selfDestructAs                = [[FAC_PLATEEX]],
  showNanoSpray                 = false,
  sightDistance                 = 273,
  useBuildingGroundDecal        = true,
  workerTime                    = Shared.FACTORY_BUILDPOWER,
  yardMap                       = "oooooo oooooo oooooo oooooo yyyyyy yyyyyy yyyyyy yyyyyy",

  featureDefs                   = {

    DEAD = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 6,
      footprintZ       = 8,
      object           = [[plate_tank_dead.s3o]],
      collisionVolumeOffsets = [[0 14 -34]],
      collisionVolumeScales  = [[110 28 44]],
      collisionVolumeType    = [[box]],
    },


    HEAP = {
      blocking         = false,
      footprintX       = 6,
      footprintZ       = 8,
      object           = [[debris4x4a.s3o]],
    },

  },

} }
