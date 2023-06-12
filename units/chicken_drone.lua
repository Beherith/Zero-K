return { chicken_drone = {
  unitname            = [[chicken_drone]],
  name                = [[Drone]],
  description         = [[Morphs Into Chicken Structures]],
  acceleration        = 1.08,
  activateWhenBuilt   = true,
  brakeRate           = 1.23,
  builder             = false,
  buildPic            = [[chicken_drone.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND UNARMED]],

  customParams        = {
	morphto_1 = "chickend",
	morphtime_1 = 20,
	morphcost_1 = 15,

	morphto_2 = "chickenspire",
	morphtime_2 = 90,
	morphcost_2 = 600,
  },

  energyMake          = 0,
  energyStorage       = 50,
  explodeAs           = [[SMALL_UNITEX]],
  floater             = false,
  footprintX          = 2,
  footprintZ          = 2,
  iconType            = [[builder]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  maxDamage           = 170,
  maxSlope            = 36,
  maxVelocity         = 1.8,
  maxWaterDepth       = 5000,
  metalCost           = 0,
  energyCost          = 0,
  buildTime           = 60,
  metalMake           = 0,
  metalStorage        = 50,
  movementClass       = [[AKBOT2]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK TURRET]],
  objectName          = [[chicken_drone.s3o]],
  onoffable           = true,
  power               = 60,
  pushResistant       = 0,
  reclaimable         = false,
  selfDestructAs      = [[SMALL_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },
  sightDistance       = 256,
  trackOffset         = 1,
  trackStrength       = 6,
  trackStretch        = 1,
  trackType           = [[ChickenTrack]],
  trackWidth          = 10,
  turnRate            = 967,
  upright             = false,
  waterline           = 8,
  workerTime          = 0,
} }
