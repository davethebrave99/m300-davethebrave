Vagrant.configure("2") do |config|
  
  #configure webserver
  config.vm.define "web01" do |web01|
  web01.vm.box = "centos/7"
  web01.vm.hostname = "web01"
  #web01.vm.network "private_network", ip: "10.0.2.1"
    web01.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
    web01.vm.network "forwarded_port", guest:443, host:4343, auto_correct: true
    web01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "web01"
    end
    web01.vm.provision "shell", path: "web01.sh"
  end

  #Configure db server
  config.vm.define "db01" do |db01|
  db01.vm.box = "centos/7"
  db01.vm.hostname = "db01"
  #db01.vm.network "private_network", ip: "10.0.2.2"
    db01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "db01"
    end
    db01.vm.provision "shell", path: "db01.sh"
  end

  #Configure master server
  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = "master"
    #master.vm.network "private_network", ip: "10.0.2.3"
      master.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.name = "master"
      end
      master.vm.provision "shell", path: "master.sh"
    end

  #configure ubuntu webserver
  config.vm.define "web01ubuntu" do |web01ubuntu|
    web01ubuntu.vm.box = "ubuntu/trusty64"
    web01ubuntu.vm.hostname = "web01ubuntu"
    #web01.vm.network "private_network", ip: "10.0.2.1"
      web01ubuntu.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
      web01ubuntu.vm.network "forwarded_port", guest:443, host:4343, auto_correct: true
      web01ubuntu.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.name = "web01-ubuntu"
      end
      web01ubuntu.vm.provision "shell", path: "web01-ubuntu.sh"
  end

end

