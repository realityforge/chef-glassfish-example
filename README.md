chef-glassfish-example
======================

A chef repository that demonstrates the use of the chef-glassfish cookbook.
The repository contains a multi-node Vagrantfile where each node defined
in the Vagrantfile demonstrates different features of the glassfish cookbook.

The following virtual machines are defined:

* `glassfish-secure-example`: An example of configuring a glassfish domain
  that uses local SSL connections to communicate with the domain controller.
* `glassfish-example`: An example that supports remote administration of the
  glassfish domain controller.
