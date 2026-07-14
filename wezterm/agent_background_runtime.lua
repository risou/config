local wezterm = require("wezterm")

local config_root = ...

local agent_background = dofile(config_root .. "/wezterm/agent_background.lua")

local background_specs = {
	fish = {
		path = config_root .. "/wezterm/backgrounds/fish-phase-weave.png",
		hsb = { brightness = 0.38, saturation = 0.85 },
	},
	nvim = {
		path = config_root .. "/wezterm/backgrounds/nvim-teal-silence.png",
		hsb = { brightness = 0.38, saturation = 0.8 },
	},
	cursor = {
		path = config_root .. "/wezterm/backgrounds/cursor-prototype-bloom.png",
		hsb = { brightness = 0.38, saturation = 0.85 },
	},
	claude = {
		path = config_root .. "/wezterm/backgrounds/claude-work.png",
		hsb = { brightness = 0.38, saturation = 0.7 },
	},
	codex = {
		path = config_root .. "/wezterm/backgrounds/codex-phase-weave.png",
		hsb = { brightness = 0.38, saturation = 0.85 },
	},
}

local warned = {}

local function warn_once(key, message)
	if warned[key] then
		return
	end
	warned[key] = true
	wezterm.log_warn(message)
end

local function file_exists(path)
	local file = io.open(path, "rb")
	if not file then
		return false
	end
	file:close()
	return true
end

local function load_herdr_snapshot()
	local success, stdout, stderr = wezterm.run_child_process({ "/opt/homebrew/bin/herdr", "api", "snapshot" })
	if not success then
		warn_once("herdr-snapshot", "Unable to read Herdr snapshot: " .. (stderr or "unknown error"))
		return nil
	end

	local ok, payload = pcall(wezterm.json_parse, stdout)
	if not ok then
		warn_once("herdr-json", "Unable to parse Herdr snapshot JSON")
		return nil
	end
	return payload
end

local function available_spec(mode)
	local spec = background_specs[mode] or background_specs.fish

	if file_exists(spec.path) then
		return spec
	end

	warn_once(spec.path, "WezTerm background image is missing: " .. spec.path)

	if spec ~= background_specs.fish and file_exists(background_specs.fish.path) then
		return background_specs.fish
	end

	return nil
end

local function update_agent_background(window, pane)
	local mode = agent_background.detect(pane:get_foreground_process_info(), load_herdr_snapshot)
	local image_spec = available_spec(mode)

	local overrides = window:get_config_overrides() or {}
	local current_path = overrides.window_background_image
	local desired_path = image_spec and image_spec.path or nil
	local current_hsb = overrides.window_background_image_hsb or {}
	local desired_hsb = image_spec and image_spec.hsb or {}

	if
		current_path == desired_path
		and current_hsb.brightness == desired_hsb.brightness
		and current_hsb.saturation == desired_hsb.saturation
	then
		return
	end

	agent_background.with_background(overrides, image_spec)
	window:set_config_overrides(overrides)
end

return update_agent_background
