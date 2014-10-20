def define_node(config, name, glassfish_config)
  config.vm.define name do |client|
    client.vm.hostname = "#{name}-vm"

    client.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'java::default'
      chef.add_recipe 'glassfish::attribute_driven_domain'

      chef.json = {
        'java' => {
          'install_flavor' => 'oracle',
          'jdk_version' => 7,
          'oracle' => {
            'accept_oracle_download_terms' => true
          }
        },
        'glassfish' => glassfish_config
      }
    end
  end
end

Vagrant.configure('2') do |config|

  # VM Configuration
  config.vm.box = 'hashicorp/precise32'

  # Common provisioning
  config.vm.provision :shell, :inline => 'apt-get update'
  config.vm.provision :shell, :inline => 'apt-get install build-essential ruby1.9.1-dev --no-upgrade --yes'
  config.vm.provision :shell, :inline => 'gem install chef --version 11.16.4 --no-rdoc --no-ri --conservative'

  # SSH Configuration
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  define_node(config,
              'glassfish-example',
              'version' => '4.1',
              'package_url' => 'http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip',
              'domains' => {
                'mydomain' => {
                  'config' => {
                    'port' => 7070,
                    'admin_port' => 4848,
                    'username' => 'admin',
                    'password' => 'admin',
                    'master_password' => 'mykeystorepassword',
                    'remote_access' => true
                  }
                }
              })

  define_node(config,
              'glassfish-secure-example',
              'version' => '4.1',
              'package_url' => 'http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip',
              'domains' => {
                'mydomain' => {
                  'config' => {
                    'port' => 7070,
                    'admin_port' => 4848,
                    'username' => 'admin',
                    'password' => 'admin',
                    'master_password' => 'mykeystorepassword',
                    'remote_access' => true,
                    'secure' => true
                  }
                }
              })

  define_node(config,
              'glassfish-example-with-library',
              'version' => '4.1',
              'package_url' => 'http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip',
              'domains' => {
                'mydomain' => {
                  'config' => {
                    'port' => 7070,
                    'admin_port' => 4848,
                    'username' => 'admin',
                    'password' => 'admin',
                    'master_password' => 'mykeystorepassword',
                    'remote_access' => true
                  },
                  'extra_libraries' => {
                    'jtds' => {
                      'url' => 'http://central.maven.org/maven2/net/sourceforge/jtds/jtds/1.2.7/jtds-1.2.7.jar',
                      'requires_restart' => true
                    }
                  }
                }
              })
end
