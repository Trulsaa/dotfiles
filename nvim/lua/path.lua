local function split(s, delimiter)
  local result = {}
  for match in string.gmatch((s .. delimiter), "(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local function table_length(t)
  local lengthNum = 0
  for _ in pairs(t) do
    lengthNum = lengthNum + 1
  end
  return lengthNum
end

local function isStringInTable(s, t)
  local is = false
  for _, str in ipairs(t) do
    if str == s then
      is = true
    end
  end
  return is
end

local function removeAngularFolderName(path)
  local substrings = split(path, "/")
  local lengthNum = table_length(substrings)
  local folder = substrings[lengthNum - 1]
  local file = substrings[lengthNum]
  local fileTable = split(file, "%.")
  local found = isStringInTable(folder, fileTable)
  if found then
    substrings[lengthNum - 1] = "-"
  end
  return table.concat(substrings, "/")
end

local function format(path)
  local cwdAndPath = vim.fn.getcwd() .. path
  local editedPath = path

  if string.find(cwdAndPath, "aize") ~= nil then
    editedPath = string.gsub(path, "applications", "a")
    if string.find(path, "web-client", 1, true) then
      editedPath = removeAngularFolderName(editedPath)
    end
  end

  if string.find(cwdAndPath, "aize/vcp") ~= nil then
    editedPath = string.gsub(editedPath, "io/aize/vcp/clientapi", "...")
  elseif string.find(cwdAndPath, "aize/twin-explorer", 1, true) ~= nil then
    editedPath = string.gsub(editedPath, "java/io/aize/twin/explorer", "...")
  end
  return editedPath
end

local function literalize(str)
  return str:gsub(
    "[%(%)%.%%%+%-%*%?%[%]%^%$]",
    function(c)
      return "%" .. c
    end
  )
end

local function removeCwdFromPath(path)
  local cleanCwd = vim.fn.getcwd() .. "/"
  return string.gsub(path, literalize(cleanCwd), "")
end

return {format = format, removeCwdFromPath = removeCwdFromPath}
