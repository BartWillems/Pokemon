#!/bin/bash

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -j|--jar)
    JAR="$2"
		# The game path should be an absolute path
		GAME_PATH=$(dirname $JAR)
		CONF_PATH=$GAME_PATH/config.properties
    shift 
    ;;
    -lo|--long)
    LONG="$2"
    shift
    ;;
    -la|--lat)
    LAT="$2"
    shift
    ;;
    -u|--username)
    USERNAME="$2"
    shift
    ;;
    -p|--password)
		PASSW=true
    shift
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

#SET PARAM
if [[ $PASSW ]]; then
		BASE_PASS=$(read -s -p "Enter your password")
		BASE_PASS=$(echo "$BASE_PASS" | base64)
		sed -i "/^base64_password=/c\base64_password=$BASE_PASS" $CONF_PATH
		sed -i "/^password=/c\password=" $CONF_PATH
fi

if [[ "$USERNAME" ]]; then
		sed -i "/^username=/c\username=$USERNAME" $CONF_PATH
fi

if [[ "$LONG" ]]; then
		sed -i "/^longitude=/c\longitude=$LONG" $CONF_PATH
fi

if [[ "$LAT" ]]; then
		sed -i "/^latitude=/c\latitude=$LAT" $CONF_PATH
fi

#RUN GAME
TEMP=$(nohup java -jar $JAR &)
OUTPOUT=$(tail -n 10 nohup.out)
AUTH_CODE_STR=$($OUTPUT | grep 'https://www.google.com/device')

if [[ $AUTH_CODE_STR ]];then
		$AUTH_CODE_STR=$(echo $AUT_CODE_STR | rev | cut -d: -f1 | rev)
		echo "Please enter the code: $AUTH_CODE_STR in https://www.google.com/device"
fi

tail -f nohup.out | grep Caught
