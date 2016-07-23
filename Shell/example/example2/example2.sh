#!/bin/bash


if [ $# -lt 2 ]
then
	echo cau lenh co it hon 2 tham so
	exit 1
fi


[ ${1} != ${2} ]

echo $?
