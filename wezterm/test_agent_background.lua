package.path = "./?.lua;./?/init.lua;" .. package.path

local background = require("wezterm.agent_background")

local function assert_equal(actual, expected, message)
	if actual ~= expected then
		error(string.format("%s: expected %s, got %s", message, tostring(expected), tostring(actual)))
	end
end

local snapshot = {
	result = {
		snapshot = {
			focused_pane_id = "wZ:p1",
			panes = {
				{ pane_id = "wC:p1", focused = false, agent = "claude" },
				{ pane_id = "wZ:p1", focused = true, agent = "codex" },
			},
		},
	},
}

assert_equal(background.agent_from_snapshot(snapshot), "codex", "focused Herdr pane")
assert_equal(background.detect("/opt/homebrew/bin/claude", function() return nil end), "claude", "direct Claude")
assert_equal(background.detect("/opt/homebrew/bin/codex", function() return nil end), "codex", "direct Codex")
assert_equal(
	background.detect(
		"/opt/homebrew/Caskroom/codex/0.144.1/codex-aarch64-apple-darwin",
		function() return nil end
	),
	"codex",
	"Homebrew Codex binary"
)
assert_equal(background.detect("/opt/homebrew/bin/fish", function() return snapshot end), nil, "ordinary shell")
assert_equal(background.detect("/opt/homebrew/bin/herdr", function() return snapshot end), "codex", "Herdr snapshot")
assert_equal(background.detect("/opt/homebrew/bin/herdr", function() error("socket unavailable") end), nil, "Herdr failure")

local overrides = { font_size = 16.0, window_background_opacity = 1.0 }
background.with_background(overrides, {
	path = "/wallpapers/claude.png",
	hsb = { brightness = 0.38, saturation = 0.75 },
})
assert_equal(overrides.font_size, 16.0, "font override is preserved")
assert_equal(overrides.window_background_opacity, 1.0, "opacity override is preserved")
assert_equal(overrides.window_background_image, "/wallpapers/claude.png", "image is applied")
assert_equal(overrides.window_background_image_hsb.brightness, 0.38, "HSB is applied")

background.with_background(overrides, nil)
assert_equal(overrides.window_background_image, nil, "image is cleared")
assert_equal(overrides.window_background_image_hsb, nil, "HSB is cleared")
assert_equal(overrides.font_size, 16.0, "font override survives clearing")

print("agent_background tests passed")
