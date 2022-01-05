local LUA_DIR = '$HOME/.config/nvim/lua/'

local function sourceLuaFiles(subpath)
  local p = io.popen('ls ' .. LUA_DIR .. subpath .. '| grep .lua')
  for filename in p:lines() do
    local fsPath = subpath .. filename
    local requirePath = fsPath:gsub('%.lua', ''):gsub('/', '.')
    require(requirePath)
  end
end

sourceLuaFiles('')
sourceLuaFiles('plugins/')
