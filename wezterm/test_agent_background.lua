package.path = "./?.lua;./?/init.lua;" .. package.path

local background = require("wezterm.agent_background")

local function assert_equal(actual, expected, message)
	if actual ~= expected then
		error(string.format("%s: expected %s, got %s", message, tostring(expected), tostring(actual)))
	end
end

local function process(executable, argv0)
	return {
		executable = executable,
		argv = argv0 and { argv0 } or {},
	}
end

local CURSOR_PROCESS_FIXTURE = process(
	"/Users/masaakifujisawa/.local/share/cursor-agent/versions/2026.07.09-a3815c0/node",
	"/Users/masaakifujisawa/.local/bin/agent"
)

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
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/claude", "claude"),
		function() return nil end
	),
	"claude",
	"direct Claude"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/codex", "codex"),
		function() return nil end
	),
	"codex",
	"direct Codex"
)
assert_equal(
	background.detect(
		process(
			"/opt/homebrew/Caskroom/codex/0.144.1/codex-aarch64-apple-darwin",
			"codex"
		),
		function() return nil end
	),
	"codex",
	"Homebrew Codex binary"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/nvim", "nvim"),
		function() return nil end
	),
	"nvim",
	"direct nvim"
)
assert_equal(
	background.detect(CURSOR_PROCESS_FIXTURE, function() return nil end),
	"cursor",
	"direct Cursor Agent"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/fish", "fish"),
		function() return snapshot end
	),
	"fish",
	"ordinary shell fallback"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/node", "node"),
		function() return nil end
	),
	"fish",
	"generic Node fallback"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/herdr", "herdr"),
		function() return snapshot end
	),
	"codex",
	"Herdr snapshot"
)
assert_equal(
	background.detect(
		process("/opt/homebrew/bin/herdr", "herdr"),
		function() error("socket unavailable") end
	),
	"fish",
	"Herdr failure fallback"
)
assert_equal(background.detect(nil, function() return nil end), "fish", "unknown process fallback")

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
