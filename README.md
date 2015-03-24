# Tiny Puppet Playground

## A place where to test and play with [Tiny Puppet](https://github.com/example42/puppet-tp)

You can test Tiny Puppet on different Operating Systems with Tiny Puppet Playground with Vagrant:

    vagrant status

The default Vagrantfile uses the cachier plugin, you can install it with:

    vagrant plugin install vagrant-cachier

You absolutely need to have the VirtualBox guest additions working on the Vagrant's VMs, if the provided ones are not updated you may use the VBguest plugin to automatically install them:

    vagrant plugin install vagrant-vbguest

Besides the ```Vagrantfile``` all the Vagrant specific stuff is under the ```vagrant``` directory.

The default manifest is ```vagrant/manifests/site.pp```, you can play with Tiny Puppet there and verify there what you can do with it.

Public modules, which are required or optional dependencies for Tiny Puppet are under ```modules/public```, populate them with Librarian Puppet:

    librarian-puppet install --puppetfile Puppetfile --path modules/public

On the shell of your VM you can run Puppet (same effect of ```vagrant provision```) with:

    root@ubuntu1404:/#  /vagrant/bin/papply_vagrant.sh 

this does a puppet apply on /vagrant/vagrant/manifests/site.pp with the correct parameters.

If you specify a different manifest, puppet apply is done on it:

    root@ubuntu1404:/#  /vagrant/bin/papply_vagrant.sh test.pp 

### Acceptance tests

The ```bin/test.sh``` script is the quickest way to test how Tiny Puppet manages different applications on different Operating Systems.

You need to run the VM you want to test on:

    vagrant up Ubuntu1404

and then execute commands like these:

  - To test apache installation on Ubuntu1404:

    ```bin/test.sh apache Ubuntu1404```

  - To test ALL the supported applications on Centos7:

    ```bin/test.sh all Centos7```

  - To test ALL the applications on Centos7 and save the results in the ```acceptance``` dir:

    ```bin/test.sh all Centos7 acceptance```

  - To run puppi check for proftpd applications on Centos7:

    ```bin/test.sh all Centos7 puppi```


Do not expect everything to work seamlessly, this is a test environment to verify functionality and coverage on different Operating Systems. 


### Compatibility matrix

Routinely the results of acceptance tests are saved in the [```acceptance```](https://github.com/example42/tp-playground/tree/master/acceptance)  directory: use it as a reference on the current support matrix of different applications on different Operating Systems.

Note however that Tiny Puppet support may extend to other OS: the acceptance tests use directly ```puppet apply``` on ```tp``` defines, so they need to run locally and have the expected prerequisites (such as the Ruby version).

Note also that some tests fail for trivial reasons such as the absence of a valid configuration file by default or missing data to configure dedicated repositories or execution order issues while running tests on the same VM or errors in the test scripts.

Check the output of the check scripts, under the ```success``` and ```failure``` directories for some details on the reasons some tests are failing.

