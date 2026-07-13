local M = {}

local supported_agents = {
	claude = true,
	codex = true,
}

local function basename(path)
	return (path or ""):gsub(".*[/\\]", "")
end

local function normalize_agent(agent)
	if supported_agents[agent] then
		return agent
	end
	return nil
end

local function agent_from_process(process)
	local exact_agent = normalize_agent(process)
	if exact_agent then
		return exact_agent
	end
	if process:match("^codex%-") then
		return "codex"
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

function M.detect(process_name, snapshot_loader)
	local process = basename(process_name)
	local direct_agent = agent_from_process(process)
	if direct_agent then
		return direct_agent
	end

	if process ~= "herdr" then
		return nil
	end

	local ok, payload = pcall(snapshot_loader)
	if not ok then
		return nil
	end

	return M.agent_from_snapshot(payload)
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
