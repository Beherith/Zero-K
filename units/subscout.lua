return { subscout = {
  name                  = [[Lancelet]],
  description           = [[Scout/Suicide Minisub]],
  acceleration          = 0.192,
  activateWhenBuilt     = true,
  brakeRate             = 3.0,
  builder               = false,
  buildPic              = [[subscout.png]],
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  category              = [[SUB FIREPROOF]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[18 12 38]],
  collisionVolumeType    = [[cylZ]],

  customParams          = {
    fireproof = [[1]],
    turnatfullspeed = [[1]],
  },

  explodeAs             = [[SUBSCOUT_DEATH]],
  fireState              = 0,
  footprintX            = 2,
  footprintZ            = 2,
  iconType              = [[submarine]],
  kamikaze              = true,
  kamikazeDistance      = 80,
  maxDamage             = 200,
  metalCost             = 200,
  minWaterDepth         = 15,
  movementClass         = [[UBOAT3]],
  noAutoFire            = false,
  noChaseCategory       = [[FIXEDWING SATELLITE HOVER]],
  objectName            = [[subscout.s3o]],
  script                = [[subscout.lua]],
  selfDestructAs        = [[SUBSCOUT_DEATH]],
  selfDestructCountdown = 0,
  sightDistance         = 550,
  sonarDistance         = 450,
  speed                 = 114,
  turnRate              = 800,
  upright               = true,
  waterline             = 15,
  workerTime            = 0,

    weaponDefs = {
        SUBSCOUT_DEATH = {
            name                    = [[Super Torpedo]],
            areaofeffect            = 256,
            craterboost             = 1,
            cratermult              = 4,
            edgeeffectiveness       = 0.5,
            explosionGenerator      = [[custom:exp_medium_building_small]],
            fireStarter             = 200,
            impulseboost            = 0,
            impulsefactor           = 0,
            interceptedbyshieldtype = 1,
            range                   = 200,
            reloadtime              = 3.6,
            soundhit                = [[explosion/mini_nuke]],
            turret                  = 1,
            weaponvelocity          = 250,

            damage = {
                default = 1500,
            },
        },
    },
} }
