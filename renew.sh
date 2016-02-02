#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE="$DIR/domains.conf"
LOGFILE="$DIR/cert_renew.log"
SYMLINK="$DIR/letsencrypt-auto"


if [ ! -f "$LOGFILE" ]
then
	touch "$LOGFILE"
fi


exec > >(tee -i "$LOGFILE")

exec 2>&1

printf "#################\n"
if [ ! -f "$FILE" ]
then
	printf "$(/bin/date): File $FILE not found\n"
	exit 1
else
	printf "$(/bin/date): Reading config file...\n"
fi

if [ ! -h "$SYMLINK" ]
then
	printf "$(/bin/date): File $SYMLINK is not a symbolic link\n"
	exit 1
fi

TARGET=`readlink "$SYMLINK"`
printf "letsencrypt-auto located in $TARGET\n"
COMMAND="$TARGET certonly --rsa-key-size 4096 --renew-by-default"

printf "\n$(/bin/date): Stopping Apache Webserver...\n\n"
APACHESTOP=`sudo service apache2 stop`
# APACHESTOP=`systemctl stop httpd`

while read line || [[ -n "$line" ]]; do
        TRIMMED=`echo $line`
        if [ ! -z "$TRIMMED" ] && [[ ! "$TRIMMED" =~ "#" ]]
        then
		TEMPCOMMAND="$COMMAND"
		DOMAINS=$(echo $TRIMMED | tr " " "\n")
		for DOMAIN in $DOMAINS
		do
                	printf "$(/bin/date): Found domain: $DOMAIN, length: ${#DOMAIN}\n"
			TEMPCOMMAND="$TEMPCOMMAND -d $DOMAIN"
		done
                printf "$(/bin/date): trying to execute command: $TEMPCOMMAND\n"
                eval "$TEMPCOMMAND"
        fi
done < "$FILE"

printf "\n$(/bin/date): Restarting Apache Webserver...\n"
APACHESTART=`sudo service apache2 start`
# APACHESTART=`systemctl start httpd`

