local M = {}

local supported_agents = {
	claude = true,
	codex = true,
	cursor = true,
}

local function basename(path)
	return (path or ""):gsub(".*[/\\]", "")
end

local function normalize_agent(agent)
	if agent == "agent" or agent == "cursor-agent" then
		return "cursor"
	end
	if supported_agents[agent] then
		return agent
	end
	return nil
end

local function mode_from_process(info)
	local executable = basename(info and info.executable)
	local invoked_as = basename(info and info.argv and info.argv[1])
	local direct = normalize_agent(executable) or normalize_agent(invoked_as)

	if direct then
		return direct
	end
	if executable:match("^codex%-") then
		return "codex"
	end
	if executable == "nvim" then
		return "nvim"
	end
	return nil
end

function M.agent_from_snapshot(payload)
	local snapshot = payload and payload.result and payload.result.snapshot
	if not snapshot or not snapshot.focused_pane_id then
		return nil
	end

	for _, pane in ipairs(snapshot.panes or {}) do
		if pane.pane_id == snapshot.focused_pane_id then
			return normalize_agent(pane.agent)
		end
	end

	return nil
end

function M.detect(process_info, snapshot_loader)
	local direct = mode_from_process(process_info)
	if direct then
		return direct
	end

	if basename(process_info and process_info.executable) ~= "herdr" then
		return "fish"
	end

	local ok, payload = pcall(snapshot_loader)
	if not ok then
		return "fish"
	end

	return M.agent_from_snapshot(payload) or "fish"
end

function M.with_background(overrides, image_spec)
	overrides = overrides or {}
	if image_spec then
		overrides.window_background_image = image_spec.path
		overrides.window_background_image_hsb = image_spec.hsb
	else
		overrides.window_background_image = nil
		overrides.window_background_image_hsb = nil
	end
	return overrides
end

return M
