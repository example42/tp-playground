# Default ram (can be overriden per node)
default_ram = '1024'

# Default number of cpu  (can be overriden per node)
default_cpu = '1'

Vagrant.configure("2") do |config|
  config.cache.auto_detect = true

  # See https://github.com/mitchellh/vagrant/issues/1673
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  {
    :puppetserver_centos => {
      :box       => 'puppetlabs/centos-7.0-64-puppet',
      :provision_puppet => false,
      :provision_shell  => true,
      :ram       => '2048',
      :facts     => {
        :role      => 'puppet',

      }
    },
    :puppetmaster_ubuntu => {
      :box       => 'puppetlabs/ubuntu-14.04-64-puppet',
      :provision_puppet => false,
      :provision_shell  => true,
      :ram       => '4096',
      :facts     => {
        :role      => 'puppet',
      }
    },
    :Centos7_P4 => {
      :box       => 'puppetlabs/centos-7.0-64-puppet',
      :breed     => 'puppetlabs',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Centos7 => {
      :box       => 'webhippie/centos-7',
      :breed     => 'redhat',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Centos7_PE => {
      :box       => 'puppetlabs/centos-7.0-64-puppet-enterprise',
      :breed     => 'puppetlabs',
      :provision_puppet => true,
      :provision_shell  => true,
    },
#    :Centos6 => {
#      :box      => 'puppetlabs/centos-6.6-64-puppet',
#      :provision_shell  => true,
#    },
    :Ubuntu1404_P4 => {
      :box       => 'puppetlabs/ubuntu-14.04-64-puppet',
      :breed     => 'puppetlabs',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Ubuntu1204_P4 => {
      :box       => 'puppetlabs/ubuntu-12.04-64-puppet',
      :breed     => 'puppetlabs',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Debian8 => {
      :box       => 'oar-team/debian8',
      :breed     => 'debian',
      :provision_puppet => false,
      :provision_shell  => true,
    },
    :Debian7_P4 => {
      :box       => 'puppetlabs/debian-7.8-64-puppet',
      :breed     => 'puppetlabs',
      :provision_puppet => false,
      :provision_shell  => true,
    },
#    :Debian6 => {
#      :box     => 'puppetlabs/debian-6.0.10-64-puppet',
#    },
    :OpenSuse12_3 => {
      :box     => 'opensuse-12.3-64',
      :box_url => 'http://sourceforge.net/projects/opensusevagrant/files/12.3/opensuse-12.3-64.box/download',
      :breed   => 'suse',
      :provision_puppet => false,
      :provision_shell  => true,
    },
  }.each do |name,cfg|
    memory = cfg[:ram] ? cfg[:ram] : default_ram ;
    cpu = cfg[:cpu] ? cfg[:cpu] : default_cpu ;
    config.vm.provider "virtualbox" do |v|
      v.customize [ 'modifyvm', :id, '--memory', memory.to_s ]
      v.customize [ 'modifyvm', :id, '--cpus', cpu.to_s ]
      # v.customize [ 'setextradata', :id, 'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root', '1']
    end

    config.vm.define name do |local|
      local.vm.box = cfg[:box]
      local.vm.box_url = cfg[:box_url] if cfg[:box_url]
#      local.vm.boot_mode = :gui
      local.vm.host_name = ENV['VAGRANT_HOSTNAME'] || name.to_s.downcase.gsub(/_/, '-').concat(".example42.dev")
      local.vm.provision "shell", path: 'bin/vagrant/setup-' + cfg[:breed] + '.sh', args: cfg[:puppetversion] if cfg[:breed]

# TODO Fix
      $facter_script = <<EOF
facts_dir=$(puppet config print pluginfactdest)
echo "role=puppet" > $facts_dir/facts.txt
EOF

      if cfg[:facts]


        local.vm.provision "shell", inline: $facter_script
      end


      if cfg[:provision_shell]
        local.vm.provision "shell", path: 'bin/vagrant/runpuppet.sh'
      end

      if cfg[:provision_puppet]
        local.vm.provision :puppet do |puppet|
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
