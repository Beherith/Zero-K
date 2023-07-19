return { factoryjump = {
  name                          = [[Jumpbot Factory]],
  description                   = [[Produces Jumpjet Equipped Robots]],
  buildDistance                 = Shared.FACTORY_PLATE_RANGE,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[factoryjump_aoplane.dds]],

  buildoptions                  = {
    [[jumpcon]],
    [[jumpscout]],
    [[jumpraid]],
    [[jumpblackhole]],
    [[jumpskirm]],
    [[jumpassault]],
    [[jumpsumo]],
    [[jumparty]],
    [[jumpaa]],
    [[jumpbomb]],
  },

  buildPic                      = [[factoryjump.png]],
  canMove                       = true,
  canPatrol                     = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 -18]],
  collisionVolumeScales         = [[104 70 40]],
  collisionVolumeType           = [[box]],
  selectionVolumeOffsets        = [[0 0 12]],
  selectionVolumeScales         = [[104 70 100]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
    ploppable = 1,
    aimposoffset   = [[0 0 -28]],
    midposoffset   = [[0 0 -10]],
    canjump  = [[1]],
    no_jump_handling = [[1]],
    sortName = [[5]],
    modelradius    = [[60]],
    solid_factory = [[3]],
    unstick_help   = 1,
    factorytab       = 1,
    shared_energy_gen = 1,
    parent_of_plate   = [[platejump]],

    stats_show_death_explosion = 1,

    outline_x = 250,
    outline_y = 250,
    outline_yoff = 5,
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  footprintX                    = 7,
  footprintZ                    = 7,
  iconType                      = [[facjumpjet]],
  maxDamage                     = 4000,
  maxSlope                      = 15,
  maxWaterDepth                 = 0,
  metalCost                     = Shared.FACTORY_COST,
  moveState                     = 1,
  noAutoFire                    = false,
  objectName                    = [[factoryjump.s3o]],
  script                        = [[factoryjump.lua]],
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = false,
  sightDistance                 = 273,
  useBuildingGroundDecal        = true,
  workerTime                    = Shared.FACTORY_BUILDPOWER,
  yardMap                       = [[ooooooo ooooooo ooooooo ccccccc ccccccc ccccccc ccccccc]],

  featureDefs                   = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 5,
      footprintZ       = 6,
      object           = [[factoryjump_dead.s3o]],
      collisionVolumeOffsets        = [[0 0 -18]],
      collisionVolumeScales         = [[104 70 40]],
      collisionVolumeType           = [[box]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 5,
      footprintZ       = 5,
      object           = [[debris4x4c.s3o]],
    },

  },

} }
