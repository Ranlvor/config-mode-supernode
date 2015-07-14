local uci = luci.model.uci.cursor()

local f = SimpleForm('mesh_vpn', translate('Mesh VPN'))
f.template = "admin/expertmode"

local s = f:section(SimpleSection)

local o = s:option(Value, 'mode')
o.template = "gluon/cbi/mesh-vpn-fastd-mode"

local methods = uci:get('fastd', 'mesh_vpn', 'method')
if methods == 'null' then
  o.default = 'performance'
else
  o.default = 'security'
end

function f.handle(self, state, data)
  if state == FORM_VALID then
    local site = require 'gluon.site_config'

    if data.mode == 'performance' then
      uci:set('fastd', 'mesh_vpn', 'method', 'null')
	else
	  uci:set('fastd', 'mesh_vpn', 'method', 'salsa2012+umac')
    end

    uci:save('fastd')
    uci:commit('fastd')
  end
end

return f