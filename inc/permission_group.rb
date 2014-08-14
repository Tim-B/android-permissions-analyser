require_relative 'android_xml.rb'
require_relative 'group.rb'

class PermissionGroup

  include AndroidXML
  include Group

  def initialize(node, labels)
    @labels = labels
    @node = node
    @id = node['android:name']
    @name = find_string(node['android:label'])
    @description = find_string(node['android:description'])
    @permissions = {}
  end

end