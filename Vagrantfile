# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 8080, host: 8080#, host_ip: '127.0.0.1'
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  config.vm.provision 'install dependencies', type: 'shell', privileged: true, inline: <<-SHELL
apt-get update -y
apt-get install -y git curl
apt-get install -y libv8-3.14.5
SHELL

  # 本当はrbenv (on anyenv) がいいけどコンパイルする時間も余剰CPUも無いのでrvmでbinaryを落とす
  config.vm.provision 'install user-local ruby', type: 'shell', privileged: false, inline: <<-ORGSHELL
curl -sSL https://get.rvm.io | bash -s stable
exec $SHELL -l << ASLOGINSHELL
  rvmsudo rvm requirements
  rvm use --default ruby-2.4.1 --binary --install
  gem install bundler
ASLOGINSHELL
ORGSHELL

  config.vm.provision 'update gems', type: 'shell', privileged: false, run: 'always', inline: <<-ORGSHELL
exec $SHELL -l << ASLOGINSHELL
  pushd /vagrant/src
    bundle install
  popd
ASLOGINSHELL
ORGSHELL

  config.vm.provision 'supervisor', type: 'shell', privileged: true, inline: <<-ORGSHELL
apt-get install supervisor -y
ORGSHELL

  config.vm.provision '(re)start supervisord', type: 'shell', privileged: true, run: 'always', inline: <<-ORGSHELL
\\cp -f /vagrant/jekyll-serve.supervisor.conf /etc/supervisor/conf.d/jekyll-serve.supervisor.conf
service supervisor restart
ORGSHELL

end
