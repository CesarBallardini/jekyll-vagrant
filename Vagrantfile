VAGRANTFILE_API_VERSION = "2"

bits="64" ; distro="jammy"
$msg = <<MSG
------------------------------------------------------
Local Jekill Blog

To serve the blog, run the following command inside the VM:

cd ~/CesarBallardini.github.io/ && bundle exec jekyll serve --host 192.168.33.10 --incremental

URL:
 - http://192.168.33.10:4000/

------------------------------------------------------
MSG


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "github-pages"+bits do |base|

    base.vm.post_up_message = $msg

    base.vm.boot_timeout = 600
    base.vm.box = "ubuntu/"+distro+bits
    base.vm.hostname = "jk.dev"

    base.vm.provision "shell", path: "provision/os-setup.sh", privileged: true
    base.vm.provision "shell", path: "provision/ansible-setup.sh", privileged: true
    base.vm.provision "shell", path: "provision/ansible-playbook-install.sh", privileged: false
    base.vm.provision :reload
    base.vm.provision "shell", path: "provision/ansible-run.sh", privileged: false
    base.vm.provision "shell", path: "provision/cesar-blog-install.sh", privileged: false


    base.vm.network "forwarded_port", guest: 4000, host: 4000
    base.vm.network "private_network", ip: "192.168.33.10"

    base.vm.synced_folder "www/", "/srv/www", create: true

    base.ssh.forward_agent = true

    base.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
    end
  end
end

