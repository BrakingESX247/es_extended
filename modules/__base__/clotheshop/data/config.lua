-- Copyright (c) Jérémie N'gadi
--
-- All rights reserved.
--
-- Even if 'All rights reserved' is very clear :
--
--   You shall not use any piece of this software in a commercial product / service
--   You shall not resell this software
--   You shall not provide any facility to install this particular software in a commercial product / service
--   If you redistribute this software, you must link to ORIGINAL repository at https://github.com/ESX-Org/es_extended
--   This copyright should appear in every part of the project code

Config = {}

Config.Locale = 'en'

Config.Price = 100

Config.EnableControls = true

Config.DrawDistance = 100.0
Config.Size   = {x = 1.5, y = 1.5, z = 1.0}
Config.Color  = {r = 102, g = 102, b = 204, a = 100}
Config.Type   = 1

Config.EnterOrExitShops = {
	vector3(82.3898, -1391.5900, 28.3761), -- interior binco hash: 198145
	vector3(-716.1803, -156.4596, 36.4124), -- interior ponsoboys hash: 165633
	vector3(-156.7830, -305.4158, 38.7332), -- interior ponsoboys hash: 235265
	vector3(-1200.795, -777.5494, 16.31996) -- interior suburban hash: 169217
}

Config.Shops = {
	Binco = {
		Top = {
			Strawberry = {
				Pos = vector3(71.2535, -1399.9330, 28.3761),
				Heading = 357.9329
			}
		},
		Undershirt = {
			Strawberry = {
				Pos = vector3(78.1766, -1398.6800, 28.37613),
				Heading = 85.9539
			}
		},

		Legs = {
			Strawberry = {
				Pos = vector3(79.9571, -1398.8110, 28.37613),
				Heading = 6.5831
			}
		},

		Shoes = {
			Strawberry = {
				Pos = vector3(81.1540, -1396.2010, 28.37613),
				Heading = 32.0653
			}
		}

	},

	Suburban = {
		Top = {
			Delperro = {
				Pos = vector3(-1195.901, -779.322, 16.31996),
				Heading = 31.4192
			}
		},
		Undershirt = {
			Delperro = {
				Pos = vector3(-1200.519, -774.2507, 16.31996),
				Heading = 128.5377
			}
		},

		Legs = {
			Delperro = {
				Pos = vector3(-1187.929, -764.9586, 16.31996),
				Heading = 125.4125
			}
		},

		Shoes = {
			Delperro = {
				Pos = vector3(-1188.505, -772.7775, 16.31996),
				Heading = 33.4782
			}
		}
	},

	Ponsonboys = {
		Top = {
			RockfordHills = {
				Pos = vector3(-716.0799, -151.5784, 36.4151),
				Heading = 123.0344
			},
			Burton = {
				Pos = vector3(-160.4346, -308.5920, 38.7332),
				Heading = 260.6078
			}
		},
		Undershirt = {
			RockfordHills = {
				Pos = vector3(-712.8804, -149.6335, 36.4151),
				Heading = 299.3607
			},
			Burton = {
				Pos = vector3(-164.0967, -306.9833, 38.7332),
				Heading = 71.1390
			}
		},

		Legs = {
			RockfordHills = {
				Pos = vector3(-708.8593, -161.7338, 36.4151),
				Heading = 29.9254
			},
			Burton = {
				Pos = vector3(-157.405, -296.2881, 38.7332),
				Heading = 162.3669
			}
		},

		Shoes = {
			RockfordHills = {
				Pos = vector3(-714.8780, -145.8791, 36.4151),
				Heading = 189.0122
			},
			Burton = {
				Pos = vector3(-165.5786, -311.2685, 38.7332),
				Heading = 324.0579
			}
		}

	}
}