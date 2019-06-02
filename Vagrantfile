Vagrant.configure("2") do |config|
  
  config.vm.define "web01" do |web01|
  web01.vm.box = "centos/7"
  web01.vm.hostname = "web01"
  web01.vm.network "private_network", ip: "10.0.2.1"
    web01.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
    web01.vm.network "forwarded_port", guest:443, host:4343, auto_correct: true
    web01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "web01"
    end
    web01.vm.provision "shell", path: "web01.sh"
  end

  config.vm.define "db01" do |db01|
  db01.vm.box = "centos/7"
  db01.vm.hostname = "db01"
  db01.vm.network "private_network", ip: "10.0.2.2"
    ##web01.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
    ##web01.vm.network "forwarded_port", guest:443, host:4343, auto_correct: true
    web01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "web01"
    end
    web01.vm.provision "shell", path: "web01.sh"
  end
end