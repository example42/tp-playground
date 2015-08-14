
Vagrant.configure("2") do |config|
  config.cache.auto_detect = true

  # See https://github.com/mitchellh/vagrant/issues/1673
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  {
    :Centos7 => {
      :box       => 'puppetlabs/centos-7.0-64-puppet',
    },
    :Centos7_P4 => {
      :box     => 'webhippie/centos-7',
      :breed   => 'redhatP4',
      :runpuppet => false,
    },
    :Centos7_PE => {
      :box     => 'puppetlabs/centos-7.0-64-puppet-enterprise',
      :runpuppet => true,
    },
#    :Centos6 => {
#      :box     => 'puppetlabs/centos-6.6-64-puppet',
#    },
    :Ubuntu1404 => {
      :box     => 'puppetlabs/ubuntu-14.04-64-puppet',
      :runpuppet => true,
    },
#    :Ubuntu1204 => {
#      :box     => 'puppetlabs/ubuntu-12.04-64-puppet',
#    },
    :Debian8 => {
      :box     => 'oar-team/debian8',
      :runpuppet => true,
    },
    :Debian7 => {
      :box     => 'puppetlabs/debian-7.8-64-puppet',
      :runpuppet => true,
    },
    :Debian7_P4 => {
      :box     => 'puppetlabs/debian-7.8-64-puppet',
      :breed   => 'debianP4',
      :runpuppet => false,
    },
#    :Debian6 => {
#      :box     => 'puppetlabs/debian-6.0.10-64-puppet',
#    },
    :OpenSuse12_3 => {
      :box     => 'opensuse-12.3-64',
      :box_url => 'http://sourceforge.net/projects/opensusevagrant/files/12.3/opensuse-12.3-64.box/download',
      :breed   => 'suse',
      :puppetversion => 'latest',
      :runpuppet => true,
    },
  }.each do |name,cfg|
    config.vm.define name do |local|
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url] if cfg[:box_url]
#      local.vm.boot_mode = :gui
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".example42.dev")
      local.vm.provision "shell", path: 'vagrant/bin/setup-' + cfg[:breed] + '.sh', args: cfg[:puppetversion] if cfg[:breed] 

      if cfg[:runpuppet]
      local.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = 'vagrant/hiera.yaml'
        puppet.working_directory = '/vagrant/hieradata'
        puppet.manifests_path = "vagrant/manifests"
        # puppet.manifests_path = ''
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
