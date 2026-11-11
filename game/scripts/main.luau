-- A camera and a circle in the middle of the view. Only a client draws, so both systems run there.

local WIDTH = 800
local HEIGHT = 600
local circleShape = 1 -- aylo.ShapeRenderer kind: 0 is a rectangle, 1 a circle

-- Startup: the camera looks at the middle of the view.
engine.ecs.system("circle.SpawnCamera", {
	phase = "Startup",
	side = "client",
	query = {},
	run = function(ctx)
		ctx.commands:spawn({
			["aylo.Transform"] = { position = { x = WIDTH / 2, y = HEIGHT / 2 } },
			["aylo.Camera"] = {},
		})
	end,
})

-- Startup: the circle, in the middle too.
engine.ecs.system("circle.SpawnCircle", {
	phase = "Startup",
	side = "client",
	query = {},
	run = function(ctx)
		ctx.commands:spawn({
			["aylo.Transform"] = { position = { x = WIDTH / 2, y = HEIGHT / 2 } },
			["aylo.ShapeRenderer"] = {
				kind = circleShape,
				radius = 100,
				fillColor = { x = 0.2, y = 0.6, z = 1.0, w = 1 },
				outlineColor = { x = 1, y = 1, z = 1, w = 1 },
				outlineThickness = 4,
			},
		})
	end,
})
