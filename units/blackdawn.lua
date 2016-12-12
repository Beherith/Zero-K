unitDef = {
  unitname            = [[blackdawn]],
  name                = [[Black Dawn]],
  description         = [[Heavy Raider/Assault Gunship]],
  acceleration        = 0.135,
  amphibious          = true,
  brakeRate           = 0.135,
  buildCostEnergy     = 900,
  buildCostMetal      = 900,
  builder             = false,
  buildPic            = [[BLACKDAWN.png]],
  buildTime           = 900,
  canAttack           = true,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canSubmerge         = false,
  category            = [[GUNSHIP]],
  collide             = true,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[50 15 50]],
  collisionVolumeType    = [[cylY]],
  corpse              = [[DEAD]],
  cruiseAlt           = 150,

  customParams        = {
    airstrafecontrol = [[1]],
    description_bp = [[Aeronave flutuante de assalto terrestre]],
    description_fr = [[ADAV d'Assaut Terrestre]],
	description_de = [[Bodenangriff-Kampfhubschrauber]],
	description_pl = [[Ciezki statek powietrzny wsparcia]],
    helptext       = [[The Black Dawn fires a volley of unguided rockets. It has high HP and a huge damage output, but is expensive and inaccurate, especially vs moving targets. It is best for taking on clumps of base structures, slow moving or stationary units. The Black Dawn should disengage between volleys to minimize damage taken.]],
    helptext_fr    = [[Le Black Dawn est un ADAV Air/Sol au blindage ?pais et aux missiles puissants, cependant ils sont impr?cis. Pratique pour d?truire des cibles mass?es ou non mouvantes.]],
	helptext_de    = [[Der Black Dawn feuert salvenartig ungelenkte Raketen. Er besitzt eine hohe Lebensenergie und hat einen großen Schadensoutput, aber er ist teuer und unpräzise, vor allem gegen sich bewegende Ziele. Er ist gut, um Basisstrukturen und langsame oder stationäre Einheiten zu zerstören.]],
	modelradius    = [[10]],
  },

  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  hoverAttack         = true,
  iconType            = [[heavygunshipassault]],
  maxDamage           = 3400,
  maxVelocity         = 4.5,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[Black_Dawn.s3o]],
  scale               = [[1.5]],
  script              = [[blackdawn.lua]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  sightDistance       = 585,
  turnRate            = 849,

  weapons             = {

    {
      def                = [[VTOL_SALVO]],
      mainDir            = [[0 -0.35 1]],
      maxAngleDif        = 90,
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SHIP SINK TURRET FLOAT GUNSHIP FIXEDWING HOVER]],
    },

  },


  weaponDefs          = {

    VTOL_SALVO = {
      name                    = [[Rocket Salvo]],
      areaOfEffect            = 96,
      avoidFeature            = false,
      avoidFriendly           = false,
      burst                   = 8,
      burstrate               = 0.08,
      cegTag                  = [[BANISHERTRAIL]],
      collideFriendly         = false,
      craterBoost             = 0.123,
      craterMult              = 0.246,

      customparams = {
		light_camera_height = 2500,
		light_color = [[0.55 0.27 0.05]],
		light_radius = 360,
      },

      damage                  = {
        default = 220.5,
        subs    = 11,
      },

      dance                   = 30,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:MEDMISSILE_EXPLOSION]],
      fireStarter             = 70,
      flightTime              = 5,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[hobbes.s3o]],
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 9,
      smokeTrail              = false,
      soundHit                = [[weapon/missile/rapid_rocket_hit]],
      soundStart              = [[weapon/missile/rapid_rocket_fire]],
      startVelocity           = 150,
      tolerance               = 15000,
      tracks                  = true,
      turnRate                = 1400,
      turret                  = true,
      weaponAcceleration      = 100,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 250,
      wobble                  = 8000,
    },

  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
	  collisionVolumeScales  = [[65 20 65]],
	  collisionVolumeType    = [[CylY]],
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[blackdawn_d.dae]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

}

return lowerkeys({ blackdawn = unitDef })
