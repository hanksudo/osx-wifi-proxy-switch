#!/bin/sh

# Set paths to our utilities
NETWORKSETUP=/usr/sbin/networksetup

usage ()
{
  echo 'Usage :'
  echo '\t./osx-wifi-proxy.sh on'
  echo '\t./osx-wifi-proxy.sh off'
  exit
}

current_state ()
{
    echo 'Web Proxy(HTTP) state:'
    echo `$NETWORKSETUP -getwebproxy wi-fi`
    echo '\r'
    echo 'Secure Web Proxy(HTTPS) state:'
    echo `$NETWORKSETUP -getsecurewebproxy wi-fi`
    echo '\r'
}

current_state

if [ "$#" -ne 1 ]
then
  usage
fi

STATE=$1

if [ "$STATE" = "on" ] || [ "$STATE" = "off" ]
then
    echo "Turning $STATE proxy..."
    echo '\r'
    `sudo $NETWORKSETUP -setwebproxystate wi-fi $STATE`
    `sudo $NETWORKSETUP -setsecurewebproxystate wi-fi $STATE`
    current_state
    exit
fi

usage


# # Determines which OS the script is running on
# osvers=$(sw_vers -productVersion | awk -F. '{print $2}')

# # On 10.7 and higher, the Wi-Fi interface needs to be identified.
# # On 10.5 and 10.6, the Wi-Fi interface should be named as "AirPort"

# if [[ ${osvers} -ge 7 ]]; then
#     wifiDevice=`/usr/sbin/networksetup -listallhardwareports | awk '/^Hardware Port: Wi-Fi/,/^Ethernet Address/' | head -2 | tail -1 | cut -c 9-`
#     /usr/sbin/networksetup -setnetworkserviceenabled Wi-Fi on
# else
#     wifiDevice=`/usr/sbin/networksetup -listallhardwareports | awk '/^Hardware Port: AirPort/,/^Ethernet Address/' | head -2 | tail -1 | cut -c 9-`
#     /usr/sbin/networksetup -setnetworkserviceenabled AirPort on
# fi

# # Set the SSID variable to your wireless network name
# # to set the network name you want to connect to.
# # Note: Wireless network name cannot contain spaces.
# SSID=ssh

# # Set the INDEX variable to the index number you'd like
# # it to be assigned to (leave it as "0" if you do not know
# # what index number to use.)
# INDEX=0

# # Set the SECURITY variable to the security type of the
# # wireless network (NONE, WEP, WPA, WPA2, WPAE or
# # WPA2E) Setting it to NONE means that it's an open
# # network with no encryption.
# SECURITY=WPA2

# # Set the password here. For example, if you are using WPA
# # encryption with a password of "thedrisin", set the PASSWORD
# # variable to "thedrisin" (no quotes.)
# PASSWORD=pass

# # Once the running OS is determined, the settings for the specified
# # wireless network are created and set as the first preferred network listed

# if [[ $wifiDevice == "" ]]; then
#     echo "No Wi-Fi device found!"
#     exit 0;
# fi

# # Run our tests first
# airportScan=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s`
# preferredList=`/usr/sbin/networksetup -listpreferredwirelessnetworks $wifiDevice`

# # First: turn on wifi
# /usr/sbin/networksetup -setairportpower $wifiDevice on


# # Does the wifi even exist?
# if [[ -n "$airportScan | grep $SSID" ]]; then
#     # Yes, the wifi exists.  Is it already on the preferred list?
#     if [[ -z `echo $preferredList | grep $SSID` ]]; then
#         # No, it isn't in the preferred list, so we set the connection right now.
#         /usr/sbin/networksetup -setairportnetwork $wifiDevice $SSID $PASSWORD
#         echo "Setting network now."
#         exit 0;
#     fi
#     # If it gets here, it is on the preferred list and the wifi exists, so it should join automatically (or have another SSID to join).
# fi

# # If it gets here, the wifi doesn't exist, so we shouldn't try to join it right now.  Add it to the preferred list.
# echo "Setting network later."
# /usr/sbin/networksetup -addpreferredwirelessnetworkatindex $wifiDevice $SSID $INDEX $SECURITY
