#
# Copyright Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Asadmin

use_inline_resources

action :create do

  command = []
  command << 'create-jdbc-resource'
  command << '--connectionpoolid' << new_resource.connectionpoolid
  command << '--property' << encode_parameters(new_resource.properties) unless new_resource.properties.empty?
  command << '--description' << "'#{new_resource.description}'" if new_resource.description
  command << "--enabled=#{new_resource.enabled}" if new_resource.enabled
  command << asadmin_target_flag
  command << new_resource.name

  bash "asadmin_create_jdbc_resource #{new_resource.name}" do
    not_if "#{asadmin_command('list-jdbc-resources')} #{new_resource.target}| grep -F -x -- '#{new_resource.name}'"
    user new_resource.system_user
    group new_resource.system_group
    code asadmin_command(command.join(' '))
  end

  sets = {'pool-name' => new_resource.connectionpoolid, 'description' => new_resource.description}
  new_resource.properties.each_pair do |key, value|
    sets["property.#{key}"] = value
  end
  sets['enabled'] = !!new_resource.enabled
  sets.each_pair do |key, value|
    variable = "resources.jdbc-resource.#{new_resource.name}.#{key}"
    glassfish_property "#{variable}=#{value}" do
      domain_name new_resource.domain_name
      admin_port new_resource.admin_port
      username new_resource.username
      password_file new_resource.password_file
      secure new_resource.secure
      key variable
      value value.to_s
    end
  end
end

action :delete do
  command = []
  command << 'delete-jdbc-resource'
  command << asadmin_target_flag
  command << new_resource.name

  bash "asadmin_delete_jdbc_resource #{new_resource.name}" do
    only_if "#{asadmin_command('list-jdbc-resources')} #{new_resource.target} | grep -F -x -- '#{new_resource.name}'"
    user new_resource.system_user
    group new_resource.system_group
    code asadmin_command(command.join(' '))
  end
end
