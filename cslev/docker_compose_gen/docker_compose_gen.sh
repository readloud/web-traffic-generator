#!/bin/bash
 
source sources/extra.sh

DEFAULT_NUM=10
DEFAULT_META="cloudlabs_utah_intel64"
DEFAULT_ARCH="latest"

function show_help 
 { 
 	c_print "Green" "This script generates a docker-compose.yml file by adding the number of required services to one file. You want to run 20 container, then this script generates your the yaml file ...!"
 	c_print "Bold" "Usage: ./docker_compose_gen.sh -n <NUM> -a <ARCH> -m <META>"
 	c_print "Bold" "\t\t-n <NUM>: set the number of required docker containers (Default: ${DEFAULT_NUM})."
	c_print "Bold" "\t\t-a <ARCH>: set the architecture the container will run on top. 'latest' is generic x86_64, while 'aarch64' is for ARM 64-bit (Default: ${DEFAULT_ARCH})."
 	c_print "Bold" "\t\t-m <META>: set the metadata for the container (Default: ${DEFAULT_META})."
 	exit
 }

NUM=""
META=""
ARCH=""

while getopts "h?n:m:a:" opt
 do
 	case "$opt" in
 	h|\?)
 		show_help
 		;;
 	n)
 		NUM=$OPTARG
 		;;
 	m)
 		META=$OPTARG
 		;;
	a)
 		ARCH=$OPTARG
 		;;
 	*)
 		show_help
 		;;
 	esac
 done


if [ -z $NUM ] || [ -z $META ] || [ -z $ARCH ]
 then
 	c_print "Yellow" "Undefined arguments - falling back to defaults"
 	if [ -z $NUM ]
	 then
	 	NUM=$DEFAULT_NUM
		c_print "Yellow" "NUM=${NUM}"
	fi
	if [ -z $META ]
	 then
	 	META=$DEFAULT_META
		c_print "Yellow" "META=${META}"
	fi
	if [ -z $ARCH ]
	 then
	 	ARCH=$DEFAULT_ARCH
		c_print "Yellow" "ARCH=${ARCH}"
	fi
 fi

c_print "Blue" "Preparing base skeleton..." 1
cat sources/base_skeleton.yml > docker-compose_${NUM}.yml
retval=$(echo $?)
check_retval $retval

c_print "Blue" "Generating the rest of the yaml file..." 1
for i in $(seq 1 ${NUM})
do
	cat sources/service_template.yml | sed "s/\[\[TEMPLATE_NUMBER\]\]/${i}/g" |sed "s/\[\[TEMPLATE_META\]\]/${META}/g" | sed "s/\[\[TEMPLATE_ARCH\]\]/${ARCH}/g">> docker-compose_${NUM}.yml
done
retval=$(echo $?)
check_retval $retval




