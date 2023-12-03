return { gunshipbomb = {
  name                   = [[Blastwing]],
  description            = [[Flying Bomb/Scout (Burrows)]],
  acceleration           = 0.25,
  brakeRate              = 0.2,
  builder                = false,
  buildPic               = [[gunshipbomb.png]],
  canFly                 = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canSubmerge            = false,
  category               = [[GUNSHIP]],
  collide                = false,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[20 20 20]],
  collisionVolumeType    = [[ellipsoid]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[48 48 48]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],
  cruiseAltitude         = 30,

  customParams           = {
    landflystate   = [[1]],
    idle_cloak = 1,
    stats_detonate_weapon = [[gunshipbomb_gunshipbomb_bomb]],
  },

  explodeAs              = [[TINY_BUILDINGEX]],
  --fireState              = 0,
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 100,
  hoverAttack            = true,
  iconType               = [[gunshipspecial]],
  kamikaze               = true,
  kamikazeDistance       = 60,
  kamikazeUseLOS         = true,
  maneuverleashlength    = [[1240]],
  maxSlope               = 36,
  metalCost              = 45,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM SATELLITE SUB]],
  objectName             = [[f-1.s3o]],
  script                 = [[gunshipbomb.lua]],
  selfDestructAs         = [[TINY_BUILDINGEX]],
  selfDestructCountdown  = 0,
  sightDistance          = 500,
  speed                  = 246,
  turnRate               = 1144,
  upright                = false,
  workerTime             = 0,

  featureDefs            = {

    DEAD      = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris2x2a.s3o]],
    },

    HEAP      = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

  weaponDefs = {
    gunshipbomb_bomb = {
      name                    = [[Blastwing Bomb]],
      areaOfEffect       = 256,
      cegTag             = [[blastwingtrail]],
      craterBoost        = 1,
      craterMult         = 3.5,

      customParams          = {
        setunitsonfire = "1",
        burnchance     = "1",
        burntime = 720,

        --lups_heat_fx = [[firewalker]],
      },

      damage                  = {
        default = 300,
      },

      explosionGenerator      = [[custom:blastwing]],
      edgeeffectiveness       = 0.9,
      explosionSpeed          = 10000,
      firestarter             = 180,
      impulseBoost            = 0.1,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[f-1_bomb.dae]],
      myGravity               = 0.34,
      noSelfDamage            = true,
      range                   = 750,
      reloadtime              = 5.6,
      soundHit                = [[explosion/burn_explode]],
      turret                  = false,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },
  }
} }
