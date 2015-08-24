local unitName  =  "ufo"

unitDef = {
	--Internal settings
	objectName             = "ufo.dae",
    name                   = "UFO",
    unitName               = unitName,
    script                 = unitName .. ".lua",

	-- Movement
	acceleration           = 0.9,
	--airHoverFactor         = 0.1, -- How much the unit moves while hovering on the spot
    airHoverFactor         = -1, --allows it to land
	brakeRate              = 0.6,
	maxVelocity            = 400,
	cruiseAlt              = 350,
    verticalSpeed          = 20,
	turnRate               = 0, -- Implement turning in script
	footprintX             = 2,
	footprintZ             = 2,

	useSmoothmesh          = false, -- Broken, do not use it.
	bankingAllowed         = false,
	canFly                 = true,
	floater                = true,
	hoverAttack            = true,
	canSubmerge            = false,
	turnInPlaceAngleLimit  = 180,

	customParams           = {
		modelradius        = "18",
		midposoffset       = "0 0 0",
	},

	-- Abiltiies
	firestate              = 0,
	builder                = false,
	canAttack              = true,
	canGuard               = true,
	canMove                = true,
	canPatrol              = true,
	canStop                = true,
	collide                = true,
	upright                = true,

	category               = "ufo",

	-- Hitbox
	collisionVolumeOffsets = "0 0 0",
	collisionVolumeScales  = "180 20 180",
	collisionVolumeType    = "cylY",

	-- Attributes
	mass                   = 200,
	maxDamage              = 1000,
    -- small auto heal; additionally we'll use shields?
	autoHeal               = 5,
	idleAutoHeal           = 0,
	idleTime               = 1,

	-- Economy
	buildCostEnergy        = 100,
	buildCostMetal         = 100,
	buildTime              = 100,

	weapons                = {
		{
			def                = "incendiaryBeamLaser",
			onlyTargetCategory = "land",
		},
		{
			def                = "incendiaryBeamLaser",
			onlyTargetCategory = "land",
		},
		{
			def                = "incendiaryBeamLaser",
			onlyTargetCategory = "land",
		},
		{
			def                = "incendiaryBeamLaser",
			onlyTargetCategory = "land",
		},
		{
			def                = "gravityBeam",
			onlyTargetCategory = "land",
		},
		{
			def                = "gravityBeam",
			onlyTargetCategory = "land",
		},
		{
			def                = "gravityBeam",
			onlyTargetCategory = "land",
		},
		{
			def                = "gravityBeam",
			onlyTargetCategory = "land",
		},
		{
			def                = "independenceDayGun",
			onlyTargetCategory = "land",
		},
		{
			def                = "independenceDayGun",
			onlyTargetCategory = "land",
		},
		{
			def                = "independenceDayGun",
			onlyTargetCategory = "land",
		},
		{
			def                = "independenceDayGun",
			onlyTargetCategory = "land",
		},
		{
			def                = "pointDefense",
		},
		{
			def                = "pointDefense",
		},
		{
			def                = "pointDefense",
		},
		{
			def                = "pointDefense",
		},
		{
			def                = "blackHoleGun",
			onlyTargetCategory = "land",
		},
		{
			def                = "empBomb",
			onlyTargetCategory = "land",
		},
		{
			def                = "pulseLaser",
			onlyTargetCategory = "land",
		},
		{
			def 			   = "shield",
		},
	},

	weaponDefs             = {
		incendiaryBeamLaser = {
			name                    = "Incendiary Beam Laser",
			areaOfEffect            = 128,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,

			collideFriendly         = false,

			beamTime                = 0.01,
			beamTtl                 = 1,
			coreThickness           = 0.2,
			craterBoost             = 0,
			craterMult              = 0,

			customParams            = {
				area_damage = 1,
				area_damage_radius = 40,
				area_damage_dps = 200,
				area_damage_duration = 5,
				area_damage_range_falloff = 0.1,
				area_damage_time_falloff = 0.6,
			},

			damage                  = {
				default = 2,
			},
			explosionGenerator      = [[custom:fireflash]],
			interceptedByShieldType = 1,
			largeBeamLaser          = true,
			laserFlareSize          = 0.1,
			minIntensity            = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 0.01,
			rgbColor                = "0.6 0.1 0.1",
			scrollSpeed             = 10,
			soundTrigger            = true,
			sweepfire               = false,
			thickness               = 20,
			tileLength              = 10000,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "BeamLaser",
			weaponVelocity          = 100,
			pulseSpeed				= 0.1,
 			soundstart  			= "firemono.wav",
		},
		gravityBeam = {
			name                    = "Gravity Beam",
			areaOfEffect            = 400,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			beamTime                = 0.01,
			beamTtl                 = 1,
			coreThickness           = 0,
			craterBoost             = 0,
			craterMult              = 0,

			customParams            = {
				impulse             = "-30",
				normaldamage        = "0",
			},

			damage                  = {
				default = 2,
			},

			interceptedByShieldType = 1,
			largeBeamLaser          = true,
			laserFlareSize          = 0,
			minIntensity            = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 0.02,
			rgbColor                = "0.2 0.2 0.2",
			scrollSpeed             = 10,
			soundTrigger            = true,
			sweepfire               = false,
			thickness               = 7,
			tileLength              = 100,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "BeamLaser",
			weaponVelocity          = 500,
		},
		pointDefense = {
			name                    = "Point Defense Laser",

			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			beamTime                = 0.01,
			beamTtl                 = 10,
			burnBlow                = true,
			coreThickness           = 0,
			craterBoost             = 0,
			craterMult              = 0,

			collisionsize = 5,
			interceptor = 1,
			coverage = 400,
			interceptsolo = true,
			accuracy = 0,
			predictboost = 0,

			damage                  = {
				default = 2,
			},

			interceptedByShieldType = 1,
			largeBeamLaser          = true,
			laserFlareSize          = 0,
			minIntensity            = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 20,
			rgbColor                = "0.2 1.0 0.2",
			scrollSpeed             = 10,
			soundTrigger            = true,
			sweepfire               = false,
			thickness               = 7,
			tileLength              = 100,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "BeamLaser",
			weaponVelocity          = 500,
			soundstart  			= "pointDefense.wav",
		},
		pulseLaser = {
			name                    = "Pulse laser",
			areaOfEffect            = 128,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			coreThickness           = 0,
			craterBoost             = 0,
			craterMult              = 0,

			damage                  = {
				default = 200,
			},

			explosionGenerator      = [[custom:pulseflash]],
			interceptedByShieldType = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 0.01,
			rgbColor                = "0.2 0.5 0.2",
			soundTrigger            = true,
			thickness               = 5,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "LaserCannon",
			weaponVelocity          = 2500,
			soundstart  			= "pulse.wav",
		},
		blackHoleGun = {
			name                    = "Black Hole",
			areaOfEffect            = 500,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			collideFeature          = false,
			collideFriendly         = false,
			craterBoost             = 10,
			craterMult              = 2,

			customParams            = {
				falldamageimmunity = [[120]],

				area_damage = 1,
				area_damage_radius = 250,
				area_damage_dps = 7000,
				area_damage_is_impulse = 1,
				area_damage_duration = 8,
				area_damage_range_falloff = 0.4,
				area_damage_time_falloff = 0.6,
			},

			impulseBoost            = 150,
			impulseFactor           = -2.5,

			damage                  = {
				default = 0,
			},

			alphaDecay				= 0.2,
			size 					= 50,
			interceptedByShieldType = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 1,
			rgbColor                = "0 0 0",
			soundTrigger            = true,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "Cannon",
			weaponVelocity          = 4500,
			--soundstart  			= "pulse.wav",
		},
		empBomb = {
			name                    = "EMP Bomb",
			areaOfEffect            = 128,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			craterBoost             = 0,
			craterMult              = 0,

			damage                  = {
				default = 20,
			},

			alphaDecay				= 0.2,
			size 					= 15,
			interceptedByShieldType = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 5,
			rgbColor                = "0 0 0.7",
			soundTrigger            = true,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "Cannon",
			weaponVelocity          = 4500,
			--soundstart  			= "pulse.wav",
		},
		independenceDayGun = {
			name                    = "Independence Day Gun",
			areaOfEffect            = 128,
			avoidFeature            = false,
			avoidFriendly           = false,
			avoidNeutral            = false,
			avoidGround             = false,
			beamTime                = 0.01,
			beamTtl                 = 1,
			coreThickness           = 0.3,
			craterBoost             = 1,
			craterMult              = 1,

			damage                  = {
				default = 10000,
			},

			explosionGenerator      = [[custom:independenceflash]],
			interceptedByShieldType = 1,
			largeBeamLaser          = true,
			laserFlareSize          = 0.1,
			minIntensity            = 1,
			noSelfDamage            = true,
			range                   = 10000,
			reloadtime              = 0.01,
			rgbColor                = "0.2 0.3 0.9",
			scrollSpeed             = 10,
			soundTrigger            = true,
			sweepfire               = false,
			thickness               = 200,
			tileLength              = 10000,
			tolerance               = 5000,
			turret                  = true,
			weaponType              = "BeamLaser",
			weaponVelocity          = 100,
			pulseSpeed				= 0.1,
		},
		shield = {
			name                    = "Shield",

			damage                  = {
				default = 10,
			},

			exteriorShield          = true,
			shieldAlpha             = 1.0,
			shieldBadColor          = [[1 0.1 0.1]],
			shieldGoodColor         = [[0.1 0.1 1]],
			shieldInterceptType     = 3,
			shieldPower             = 1000,
			shieldPowerRegen        = 0, -- we'll do regen in a gadget
			shieldPowerRegenEnergy  = 0,
			shieldRadius            = 120,
			shieldRepulser          = false,
			shieldStartingPower     = 1000,
			smartShield             = true,
			smart                   = true,
-- 			texture1                = [[shield3mist]],
			visibleShield           = true,
			visibleShieldHitFrames  = 20,
			visibleShieldRepulse    = true,
			weaponType              = "Shield",
		},
	},
}

return lowerkeys({[unitName] = unitDef})
