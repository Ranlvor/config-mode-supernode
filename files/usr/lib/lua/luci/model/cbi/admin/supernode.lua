local f, s, o, ssid
local uci = luci.model.uci.cursor()
local config = 'supernode'

f = SimpleForm("supernode", translate("Supernode"))
f.template = "admin/expertmode"

s = f:section(SimpleSection, nil, translate(
	'The supernodes can block IPv6-traffic destinating to your router to protect it '
	 .. 'from attacks originating from to internet. This option does not affect clients '
	 .. 'connected to your router.'
))

o = s:option(Flag, "ipv6fw", translate("Enable IPv6 firewall"))
o.default = uci:get_first(config, config, "ipv6fw", true) and o.enabled or o.disabled
o.rmempty = false

s = f:section(SimpleSection, nil, translate(
	'The supernodes can collect varois statistics and performance-data about your router '
	 .. 'like CPU-Utilisation, Bandwidth-usage or the number of connected clients.'
))

o = s:option(Flag, "statistics", translate("Enable statistics collection"))
o.default = uci:get_first(config, config, "statistics", false) and o.enabled or o.disabled
o.rmempty = false

function f.handle(self, state, data)
  if state == FORM_VALID then
    local sname = uci:get_first(config, config)
    uci:set(config, sname, "ipv6fw", data.ipv6fw)
    uci:set(config, sname, "statistics", data.statistics)

    uci:save(config)
    uci:commit(config)
  end
end

return f
