#!/bin/bash
#
##
# provision/os-setup.sh
# instala lo necesario a nivel de sistema operativo
#

##
# Parametros de la VM
#
# vm_hostname: nombre de host dentro de la VM
vm_hostname=jk.dev

# vm_swapfilesize: si esta vacio no se crea area de swap en la VM
vm_swapfilesize=2G

############################################
##
# no hay mas que modificar desde esta linea hacia abajo
##

distro=`lsb_release -d | awk '{print $2}'`
release=`lsb_release -d | awk '{print $3}'`

aseguro_config_apt() {
  apt-get    update
}

actualizo_paquetes_sistema() {
  apt-get    update
  apt-get -y upgrade
  apt-get -y autoremove
  apt-get -y dist-upgrade
  apt-get -y autoremove
  apt-get -y autoclean
}

aseguro_un_minimo_espacio_de_swap() {
  vm_swapfilesize=$1

  if [ -n "${vm_swapfilesize}" ]
  then
    fallocate -l ${vm_swapfilesize} /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    # swapon -s  # verificar que el swap funciona
    echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab
  fi
}


mejoras_en_performance() {
  sysctl vm.swappiness=10
  echo 'vm.swappiness=10' > /etc/sysctl.conf

  sysctl vm.vfs_cache_pressure=50
  echo 'vm.vfs_cache_pressure = 50' > /etc/sysctl.conf
}

set_hostname() {
  echo '127.0.0.1   '$1 >> /etc/hosts
}

instalo_keyring() {
  [ $release == "Debian" ] && apt-get install -y debian-keyring
  [ $release == "Ubuntu" ] && apt-get install -y ubuntu-keyring ubuntu-extras-keyring
}

instalo_paquetes_esenciales() {
  apt-get install -y debconf-utils
  apt-get install -y software-properties-common build-essential
  apt-get install -y git
  apt-get install -y libxt6 libxmu6

}

###################################
##
# main
#
aseguro_config_apt
aseguro_un_minimo_espacio_de_swap ${vm_swapfilesize}
mejoras_en_performance
set_hostname ${vmhostname}

instalo_keyring
instalo_paquetes_esenciales
actualizo_paquetes_sistema
# EOF
