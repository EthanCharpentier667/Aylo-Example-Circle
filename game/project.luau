-- A window with a circle in the middle: the smallest game that draws something.
-- Run it with the runtime of an AYLO Engine release:
--   aylo-runtime game          (from the folder of this repository)

local WIDTH = 800
local HEIGHT = 600

engine.settings.network.port = engine.args.port or 4242

if engine.isClient then
	engine.settings.network.host = engine.args.host or "127.0.0.1"

	-- The plugins that draw: the window and renderer, and the plain shapes.
	engine.settings.plugins = { "aylo.graphics", "aylo.Shape" }
	engine.settings.platform = "glfw"
	engine.settings.renderer = "vulkan"

	engine.settings.window.title = "AYLO Example: Circle"
	engine.settings.window.size = { WIDTH, HEIGHT }
	engine.settings.vulkan.virtualResolution = { WIDTH, HEIGHT }
end
