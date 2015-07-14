#!/bin/sh /etc/rc.common
#place in /etc/rc.d/S99z-fastd-MTU-problem-prober
START=99
 
SERVICE_USE_PID=1
SERVICE_WRITE_PID=1
SERVICE_DAEMONIZE=1
 
BIGPROBESIZE=1492
GWA=draco.fftr
GWAuciPath=fastd.mesh_vpn_backbone_peer_draco.remote
GWB=elmira.fftr
GWBuciPath=fastd.mesh_vpn_backbone_peer_elmira.remote
 
waitForNet() {
	until ping -6 -c 10 $GWA || ping -6 -c 10 $GWB; do
		echo "Gateways do not ping at all, sleeping 1 minute"
		sleep 60
	done
}
 
checkConnection() {
	if ping -6 -c 10 -s $BIGPROBESIZE $GWA || ping -6 -c 10 -s $BIGPROBESIZE $GWB; then
		echo "big testping sucessfully, fastd is configured correctly, exiting."
		uci commit fastd
		exit
	fi
}
 
setRemotes() {
	echo "Old remotes:"
	GWAremote="$(uci get $GWAuciPath)"
	echo "$GWAremote"
	GWAremote="$(echo "$GWAremote" | sed -E 's/^ipv6 ?//g;s/^ipv4 ?//g;')"

	GWBremote="$(uci get $GWBuciPath)"
	echo "$GWBremote"
	GWBremote="$(echo "$GWBremote" | sed -E 's/^ipv6 ?//g;s/^ipv4 ?//g;')"

	echo "deleting old remotes"
	uci delete "$GWAuciPath"
	uci delete "$GWBuciPath"

	echo "adding new remotes"
	GWAremote="${1}$GWAremote"
	echo "$GWAremote"
	uci add_list "$GWAuciPath=$GWAremote"

	GWBremote="${1}$GWBremote"
	echo "$GWBremote"
	uci add_list "$GWBuciPath=$GWBremote"
}
 
restartFastd() {
	/etc/init.d/fastd stop;
	/etc/init.d/fastd start
}
 
boot () {
	(sleep 600 #give the box time to boot
	{
		#try current configuration
		waitForNet
		checkConnection

		#try ipv6 ony
		setRemotes "ipv6 "
		restartFastd
		waitForNet
		checkConnection

		#try ipv4 ony
		setRemotes "ipv4 "
		restartFastd
		waitForNet
		checkConnection

		#try dualstack
		setRemotes ""
		restartFastd
		waitForNet
		checkConnection
	 
		#ok, we did not find anything working. we will not commit anything causing no permanent change
		} 2>&1 | logger -s -t S99z-fastd-MTU-problem-prober #logg all output to syslog, too
	) &
}