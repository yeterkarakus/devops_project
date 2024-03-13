#! /bin/bash

echo "DOCKER KURULUMU"


sleep 2
echo -e "\n#### Docker Temizleme ####"
read -p "Docker silmek istiyor musunuz ? E/H " uninstallResult

if [[ $uninstallResult == 'E' ]] || [[ $uninstallResult == 'e' ]]
then
    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
    sudo apt-get clean 
    sudo apt-get autoremove -y
    sudo apt-get remove docker docker-engine docker.io containerd runc 
    sudo apt-get update 


    echo -e "\n#### Docker Temizlendi ####"
else
echo -e "\n#### Docker Silme Yapılmadı ####"
fi

#######################################################
sleep 2
echo -e "\n#### Docker Kurulumu ####"
read -p "Docker Kurulumu yapmak istiyor musunuz ? E/H :" installResult

if [[ $installResult == 'E' ]] || [[ $installResult == 'e' ]]
then
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
    
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    sudo systemctl start docker
    sudo systemctl stop docker
    sudo systemctl status docker

echo -e "\n#### Docker Kurulumu Tamamlandı ####"
else  
echo -e "\n#### Docker Kurulumu Tamamlanamadı ####"
fi

#######################################################
sleep 2
echo -e "\n ###Docker Sudo Yetkisi ###"
read -p "Yetkilendirme yapmak istiyor musunuz ? E/H :" sudoResult

if [[  $sudoResult == 'E' ]] || [[ $sudoResult == 'e' ]]
then
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    docker run hello-world
    echo -e "\n### Yetki Verildi ###"

else
    echo -e "\n### Yetki Verilmedi ###"    
fi
