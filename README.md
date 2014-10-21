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
* `glassfish-example-with-library`: An example where a library is added to
  the domain and forces the domain to restart after the library is added.
  This is typically required when the library is a database driver required
  when defining jdbc resources.
* `glassfish-example-with-common-library`: An example similar to
  `glassfish-example-with-library` except that the library is placed in the
  "common" classloader.
