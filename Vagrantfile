# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.provision :shell do |shell|
        shell.inline = "FACTER_LAN_SUBNET=$(ip route | sed -n '2p' | awk '{print $1}');
                      export FACTER_LAN_SUBNET;
                      mkdir -p /etc/puppet/modules;
                      puppet module install puppetlabs-firewall"
    end
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "site.pp"
    puppet.options = "--verbose"
  end
end