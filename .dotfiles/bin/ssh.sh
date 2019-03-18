#!/bin/bash

box=$(rofi -dmenu -matching fuzzy -p "box" << EOF
activityfeedscust-01
activityfeedscust-02
activityfeedscust-03
activityfeedssports-01
activityfeedssports-02
activityfeedssports-03
apacheext-01
apacheext-02
apacheint-01
apacheint-02
backbonebackoffice-01
backbonebackoffice-02
baldur-01
betplacement-01
betplacement-02
bonusengine-01
bonusengine-02
cashout-01
cashout-02
cashoutengine-01
cashoutengine-02
cms-01
cms-02
contentapi-01
contentapi-02
custapi-01
custapi-02
custbackoffice-01
custbackoffice-02
custsync-01
custsync-02
feedaggregator-01
feedaggregator-02
feedhandler-01
feedhandler-02
haproxy-01
haproxy-02
informix-01
informix-02
jump
kafka-01
kafka-02
kafka-03
liabilities-01
liabilities-02
liveserv-01
liveserv-02
log-01
metrics-01
metrics-02
ntp-01
ntp-02
payments-01
payments-02
playeraccount-01
playeraccount-02
playerbet-01
playerbet-02
playeridentity-01
playeridentity-02
portal-01
portal-02
postgresql-01
privatehaproxy-01
privatehaproxy-02
promobackoffice-01
promobackoffice-02
promote-ftp-01
promote-pcs-01
promote-rdp
rediscassandra-01
rediscassandra-02
rediscassandra-03
retail-backoffice-01
retail-backoffice-02
retail-betplacement-01
retail-betplacement-02
retail-liabilities-01
retail-liabilities-02
retail-liveserv-01
retail-liveserv-02
retail-search-01
retail-search-02
retail-settlement-01
retail-settlement-02
retail-siteserver-01
retail-siteserver-02
retail-sync-01
retail-sync-client-01
rewardorchestrator-01
rewardorchestrator-02
search-01
search-02
settlement-01
settlement-02
siteserver-01
siteserver-02
sportsbackoffice-01
sportsbackoffice-02
sportssync-01
sportssync-02
thor-01
varnish-01
varnish-02
wallet-01
wallet-02
yum
EOF
)

[[ -z $box ]] && exit 0
env=$(ls ~/.ssh/env | rofi -dmenu -matching fuzzy -p "enter: ssh, alt+1: copy host, alt+2: copy env")
ret=$?
[[ -z $env ]] && exit 0

if [[ $ret = 10 ]]; then
  # alt + 1
  echo ${box}.internal.${env}.sportsbook.sgdigital.com | xclip
elif [[ $ret = 11 ]]; then
  # alt + 2
  echo ${env} | xclip
else
  i3-sensible-terminal -x ssh ${box}.internal.${env}.sportsbook.sgdigital.com
fi

exit 0
