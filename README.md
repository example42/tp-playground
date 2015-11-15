# Tiny Puppet Playground

## A place where to test and play with [Tiny Puppet](http://www.tiny-puppet.com)

To install and setup the playground:

    git clone https://github.com/example42/tp-playground
    cd tp-playground
    
Public modules, which are required or optional dependencies for Tiny Puppet are expected under ```modules```, you can populate them with Librarian Puppet Simple (install it with ```gem install librarian-puppet-simple```):

    librarian-puppet install --puppetfile Puppetfile --path modules

or r10k (```gem install r10k```):

    r10k puppetfile install

You can test Tiny Puppet on different Operating Systems with Tiny Puppet Playground with Vagrant:

    vagrant status

The default [Vagrantfile](https://github.com/example42/tp-playground/blob/master/Vagrantfile#L3) uses the cachier plugin, you can install it with (comment thesecond line of Vagrant file (```config.cache.auto_detect = true```) if you don't want to use/install it:

    vagrant plugin install vagrant-cachier

You absolutely need to have the VirtualBox guest additions working on the Vagrant's VMs, if the provided ones are not updated you may use the VBguest plugin to automatically install them:

    vagrant plugin install vagrant-vbguest

Besides the ```Vagrantfile``` all the Vagrant specific stuff is under the ```vagrant``` directory.

The default manifest is ```vagrant/manifests/site.pp```, you can play with Tiny Puppet there and verify there what you can do with it.

To start and manage a VM (based on VIrtualBox) use the common vagrant commands:

    vagrant up Ubuntu1404_P4
    vagrant provision Ubuntu1404_P4
    vagrant ssh Ubuntu1404_P4

On the shell of your VM you can run Puppet (same effect of ```vagrant provision```) with:

    vagrant@ubuntu1404-p4:~$ sudo su -
    root@ubuntu1404-p4:~# /vagrant/bin/papply_vagrant.sh

this does a ```puppet apply``` on ```/vagrant/manifests/site.pp``` with the correct parameters.

If you specify a different manifest, puppet apply is done on it:

    root@ubuntu1404-p4:/#  /vagrant/bin/papply_vagrant.sh /vagrant/manifests/test.pp 


### Compatibility matrix

Check the [tp-acceptance](https://github.com/example42/tp-acceptance) repo for Tiny Puppet acceptance tests (previously included here) and the [Compatibility Matrix](https://github.com/example42/tp-acceptance/blob/master/tests/app_summary.md).

