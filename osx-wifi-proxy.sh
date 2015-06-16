#!/bin/sh

# Set paths to our utilities
NETWORKSETUP=/usr/sbin/networksetup

usage ()
{
  echo 'Usage :'
  echo "\t$0 on"
  echo "\t$0 off"
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

