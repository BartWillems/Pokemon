#!/bin/bash
# This script accepts a link from the pokévision.com website, 
# extracts the coördinates, places them in the conf file
# and removes the token(since it's borked since version 0.4)

URL=$1

LINK=${URL%@*}
COORDINATE=${URL##*@}

LAT=${COORDINATE%,*}
LONG=${COORDINATE##*,}

#sed -i "/^token=/c\token=" config.properties # Depricated, auth works again
sed -i "/^latitude=/c\latitude=$LAT" config.properties
sed -i "/^longitude=/c\longitude=$LONG" config.properties
