# Base network prefix
network_prefix = '192.168.42.'

# Default domain name
default_domain = 'example42.dev'

# Default ram (can be overriden per node)
default_ram = '1024'

# Default number of cpu  (can be overriden per node)
default_cpu = '1'

# Which Puppet server to use
default_puppet_server = 'puppetserver_centos7'

Vagrant.configure("2") do |config|
  config.cache.auto_detect = true

  # See https://github.com/mitchellh/vagrant/issues/1673
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  nodes = {
    :puppetserver_centos7 => {
      :ip               => network_prefix + '10',
      :box              => 'puppetlabs/centos-7.0-64-puppet',
      :provision        => 'papply',
      :breed            => 'puppetlabs',
      :ram              => '4096',
      :cpu              => '2',
      :role             => 'puppet',
    },
    :puppetserver_ubuntu1404 => {
      :ip               => network_prefix + '20',
      :box              => 'puppetlabs/ubuntu-14.04-64-puppet',
      :provision        => 'papply',
      :breed            => 'puppetlabs-apt',
      :ram              => '4096',
      :cpu              => '2',
      :role             => 'puppet',
    },
    :centos7 => {
      :ip               => network_prefix + '50',
      :box              => 'puppetlabs/centos-7.0-64-puppet',
      :breed            => 'puppetlabs',
      :provision        => 'papply',
      # :provision        => 'puppet_agent',
    },
    :centos7_puppet3 => {
      :box              => 'webhippie/centos-7',
      :breed            => 'redhat7',
      :provision        => 'puppet_agent',
    },
    :centos7_pe => {
      :box              => 'puppetlabs/centos-7.0-64-puppet-enterprise',
      :breed            => 'puppetlabs',
      :provision        => 'papply',
    },
    :centos6 => {
      :ip               => network_prefix + '55',
      :box              => 'puppetlabs/centos-6.6-64-puppet',
      :breed            => 'puppetlabs-centos6',
      :provision        => 'puppet_agent',
    },
    :ubuntu1404 => {
      :ip               => network_prefix + '60',
      :box              => 'puppetlabs/ubuntu-14.04-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision        => 'papply',
      # :provision        => 'puppet_agent',
    },
    :ubuntu1204 => {
      :ip               => network_prefix + '61',
      :box              => 'puppetlabs/ubuntu-12.04-64-puppet',
      :breed            => 'puppetlabs-ubuntu1204',
      :provision        => 'puppet_agent',
    },
    :debian8_puppet3 => {
      :box              => 'oar-team/debian8',
      :breed            => 'debian8',
      # :provision        => 'puppet_agent',
      :provision        => 'papply',
    },
    :debian7 => {
      :box              => 'puppetlabs/debian-7.8-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision        => 'puppet_agent',
    },
    :debian6 => {
      :box              => 'puppetlabs/debian-6.0.10-64-puppet',
      :breed            => 'puppetlabs-apt',
      :provision        => 'puppet_agent',
    },
    :opensuse12_3 => {
      :box              => 'opensuse-12.3-64',
      :box_url          => 'http://sourceforge.net/projects/opensusevagrant/files/12.3/opensuse-12.3-64.box/download',
      :breed            => 'opensuse12',
      :provision        => 'papply',
    },
  }

  nodes.each do |node,cfg|
    config.vm.define node do |local|
      memory = cfg[:ram] ? cfg[:ram] : default_ram ;
      cpu = cfg[:cpu] ? cfg[:cpu] : default_cpu ;
      local.vm.provider "virtualbox" do |v|
        v.customize [ 'modifyvm', :id, '--memory', memory.to_s ]
        v.customize [ 'modifyvm', :id, '--cpus', cpu.to_s ]
      end
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url] if cfg[:box_url]
      # local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".example42.dev")
      #local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || node.to_s.concat(".@default_domain")
      local.vm.host_name = :node.to_s.concat("." + default_domain)
      local.vm.provision "shell", path: 'bin/vagrant-setup.sh', args: cfg[:breed]
#      local.vm.boot_mode = :gui

      if cfg[:ip]
        local.vm.network "private_network", ip: cfg[:ip]
      end

      if cfg[:role]
        local.vm.provision "shell", path: 'bin/set_role.sh', args: cfg[:role]
      end

      if cfg[:provision] == 'papply'
        local.vm.provision "shell", path: 'bin/papply_vagrant.sh'
      end

      if cfg[:provision] == 'puppet_agent'
        local.vm.provision "puppet_server" do |puppet|
          puppet.puppet_server = default_puppet_server
          puppet.options = "--verbose --report"
        end
      end

      if cfg[:provision] == 'puppet_environment'
        local.vm.provision "puppet" do |puppet|
          puppet.environment_path = "."
          puppet.environment = "devel"
        end
      end

      if cfg[:provision] == 'puppet3'
        local.vm.provision "puppet" do |puppet|
          puppet.hiera_config_path = 'hiera.yaml'
          puppet.working_directory = '/vagrant/hieradata'
          puppet.manifests_path = "manifests"
          puppet.module_path = [ 'modules_local' , 'modules' ]
          puppet.manifest_file = "site.pp"
          puppet.options = [
           '--verbose',
           '--report',
           '--show_diff',
           '--pluginsync',
           '--summarize',
#        '--profile',
#        '--evaltrace',
#        '--trace',
#        '--debug',
#         '--parser future',
           '--environmentpath /vagrant',
          ]
        end
      end

    end
  end
end
