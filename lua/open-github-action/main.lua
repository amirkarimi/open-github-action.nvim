local M = {}

-- Function to extract action and version from the line
local function extract_action(line)
	local action, version = line:match("uses:%s*(%S+)%s*@%s*(%S+)")
	if action and version then
		return action, version
	end
	return nil, nil
end

-- Function to open the URL in the browser
local function open_in_browser(url)
	if vim.fn.has("mac") == 1 then
		vim.fn.system("open " .. url)
	elseif vim.fn.has("unix") == 1 then
		vim.fn.system("xdg-open " .. url)
	else
		print("Unsupported system")
	end
end

-- Function to get the current Git remote URL
local function get_git_remote_url()
	local handle = io.popen("git config --get remote.origin.url")
	local result = handle:read("*a")
	handle:close()
	return result:match("%S+")
end

-- Function to split the path into the first two segments and the rest
local function split_path(path)
	-- Match the first two segments and the rest of the path
	local output1, output2 = string.match(path, "^([^/]+/[^/]+)(/.*)$")
	-- If the path doesn't have more than two segments, output2 should be an empty string
	if not output2 then
		output1 = path
		output2 = ""
	end
	return output1, output2
end

-- Function to construct the URL for the action
local function construct_url(action, version)
	local remote_url = get_git_remote_url()
	if not remote_url then
		print("No Git remote URL found")
		return nil
	end

	-- Convert the remote URL to a HTTP URL
	remote_url = remote_url:gsub("git@([^:]+):.+.git", "https://%1")
	remote_url = remote_url:gsub("git://([^/]+)/.+.git", "https://%1")
	remote_url = remote_url:gsub("https://([^/]+)/.+.git", "https://%1")

	local segment1, segment2 = split_path(action)

	local url = string.format("%s/%s/tree/%s%s", remote_url, segment1, version, segment2)
	return url
end

-- Main function
function M.open_github_action()
	local line = vim.api.nvim_get_current_line()
	local action, version = extract_action(line)

	if action and version then
		local url = construct_url(action, version)
		if url then
			open_in_browser(url)
		else
			print("Failed to construct the URL")
		end
	else
		print("No GitHub action found on the current line")
	end
end

return M
