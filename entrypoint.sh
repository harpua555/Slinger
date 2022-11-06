#!/bin/bash

SLINGER_FILE=${SLINGER_CONF}/slinger.txt

if [ -f "$SLINGER_FILE" ]; then
	. $SLINGER_FILE
else
	#Copy sample files to /config volume if they don't already exist, does not override existing files
	cp -n ${SLINGER_APP}/sample_slinger.txt ${SLINGER_CONF}/sample_slinger.txt
	cp -n ${SLINGER_APP}/sample_xmltv.xml ${SLINGER_CONF}/sample_xmltv.xml
	cp -n ${SLINGER_APP}/slingbox.m3u ${SLINGER_CONF}/sample_slingbox.m3u
	cp -n ${SLINGER_APP}/unified_config.ini ${SLINGER_CONF}/sample_unified_config.ini
	cp -n ${SLINGER_APP}/config.ini ${SLINGER_CONF}/sample_config.ini
	cp -n ${SLINGER_APP}/config.ini ${SLINGER_CONF}/config.ini
	cp -n ${SLINGER_APP}/remote.txt ${SLINGER_CONF}/sample_remote.txt
	cp -n ${SLINGER_APP}/remote.txt ${SLINGER_CONF}/sample_remote2.txt
	mkdir ${SLINGER_APP}/CustomRemotes
	mkdir ${SLINGER_APP}/Documentation
	cp -r ${SLINGER_APP}/CustomRemotes ${SLINGER_CONF}/CustomRemotes/
	cp -r ${SLINGER_APP}/Documentation ${SLINGER_CONF}/Documentation/
	
	python3 -u ${SLINGER_APP}/slingbox_server.py ${SLINGER_CONF}/config.ini
fi

exit