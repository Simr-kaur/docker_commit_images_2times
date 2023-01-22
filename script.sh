#!/bin/bash


i=1
while [[ $i -lt 3 ]]
do
	clear
	echo "-------------------------------------------------------------"
	echo "************ $i.Process Of Container Started ***************"
	echo "--------------------------------------------------------------"
	echo "--------------------------------------------------------------"
        read -p " Enter the name you want to install inside container:->" soft
        echo "---------------------------------------------------------------"
        echo "FROM ubuntu" >> Dockerfile
        echo " RUN apt-get -y update && apt-get -y install $soft " >> Dockerfile
	echo "------------------------------------------------------"
        read -p "Enter the name of image you want to build:->" img
	echo "------------------------------------------------------"
        docker build -t $img .
	echo "------------------------------------------------------"
	read -p "Enter the name of container you want to run:->" con
	echo "------------------------------------------------------"
        docker container run -dt --name $con $img
	echo "----------------------------------------------------------------"
	echo "****************Container Start Running*******************"
	echo "----------------------------------------------------------------"
        read -p "Enter the name of image you to want to save container:->" img1
	echo "----------------------------------------------------------------"
        docker container commit $con $img1
        truncate -s 0 Dockerfile
        echo "FROM $img1" >> Dockerfile
        echo "RUN dd if=/dev/zero of=/root/file1.txt bs=1M count=500" >> Dockerfile
	echo "--------------------------------------------------------------------"
        read -p "Enter the image name to want to build using previous one:->" img2 
	echo "--------------------------------------------------------------------"
	docker build -t $img2 .
	echo "---------------------------------------------------------------"
	read -p " Enter the name of container you want to run again:-> " con1
	echo "---------------------------------------------------------------"
	docker container run -dt --name $con1 $img2
	echo "----------------------------------------------------------------------"
	read -p "Enter the name of image you want to save with final chnages:->" img3
	echo "----------------------------------------------------------------------"
	docker container commit $con1 $img3 
	docker image history $img3 >> $img3.log.txt
	echo "----------------------------------"
	echo "Image History sent to $img.log.txt"
	echo "----------------------------------"
	truncate -s 0 Dockerfile
	i=`expr $i + 1`
done
