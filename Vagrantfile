VAGRANTFILE_API_VERSION = "2"
#arch= "i386" ; bits="32" ; distro="trusty"
arch= "i386" ; bits="64" ; distro="jammy"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "github-pages"+bits do |base|

    base.vm.boot_timeout = 600
    base.vm.box = "ubuntu/"+distro+bits
    base.vm.hostname = "jk.dev"

    base.vm.provision "shell", path: "provision/os-setup.sh", privileged: true
    base.vm.provision "shell", path: "provision/ansible-setup.sh", privileged: true
    base.vm.provision "shell", path: "provision/ansible-playbook-install.sh", privileged: false
    base.vm.provision "shell", path: "provision/ansible-run.sh", privileged: false

    base.vm.network "forwarded_port", guest: 4000, host: 4000
    base.vm.network "private_network", ip: "192.168.33.10"

    base.vm.synced_folder "www/", "/srv/www", create: true

    base.ssh.forward_agent = true

    base.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
      vb.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
      vb.customize ["modifyvm", :id, "--memory", 512]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.gui = false
      #vb.name = "Jekyll Blog Vagrant "+arch+" arch"
      vb.memory = "4096"
    end
  end
end

