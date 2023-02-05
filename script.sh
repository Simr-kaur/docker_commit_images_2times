#!/bin/bash


i=1
while [[ $i -lt 3 ]]
do
	clear
	echo "-----------------------------------------------------------------------------"
	echo "******************** $i.Process Of Container Started ************************"
	echo "-----------------------------------------------------------------------------"
        read -p "Enter the name of container you want to run:->" con
	echo "-----------------------------------------------------------------------------"
        docker container run -dt --name $con ubuntu
	echo "-----------------------------------------------------------------------------"
	echo "*************************Container Start Running*****************************"
	echo "-----------------------------------------------------------------------------"
	docker exec --user root $con apt-get update -y
	read -p "Enter the name you want to install inside container:->" install
	docker exec --user root $con apt-get install $install -y
	echo "-----------------------------------------------------------------------------"
	echo "-----------------$install in install inside container------------------------"
	echo "-----------------------------------------------------------------------------"
        read -p "Enter the name of image you want to use to save container:->" img1
	echo "-----------------------------------------------------------------------------"
        docker container commit $con $img1
	echo "-----------------------------------------------------------------------------"
	echo "-------------------------$img1,image is saved.-------------------------------"
	echo "-----------------------------------------------------------------------------"
	read -p "Enter the name of container you want to run again with saved image:->" con1
	echo "-----------------------------------------------------------------------------"
	docker container run -dt --name $con1 $img1
	echo "-----------------------------------------------------------------------------"
	echo "----------------------$con1 container is running.----------------------------"
	echo "-----------------------------------------------------------------------------"
	docker exec -i $con1 bash -c "dd if=/dev/zero of=/root/file.txt bs=1M count=500"
	echo "-----------------------------------------------------------------------------"
	echo "-------------File is created inside container with 500MB size.---------------"
	echo "-----------------------------------------------------------------------------"
	read -p "Enter the name of image you want to save container with final chnages:->" img2
	echo "-----------------------------------------------------------------------------"
	docker container commit $con1 $img2 
	echo "-----------------------------------------------------------------------------"
	echo "---------------------------$img2 , final image is saved----------------------"
	echo "-----------------------------------------------------------------------------"
	docker image history $img2 >> $img2.log.txt
	echo "-----------------------------------------------------------------------------"
	echo "----------------Image History sent to $img2.log.txt--------------------------"
	echo "-----------------------------------------------------------------------------"
	i=`expr $i + 1`
done

