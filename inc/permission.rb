require_relative 'android_xml.rb'

class Permission

  include AndroidXML

  def initialize(node, labels)
    @labels = labels
    @node = node
    @id = node['android:name']
    @name = find_string(node['android:label'])
    @description = find_string(node['android:description'])
    @group = node['android:permissionGroup'] || ''

    protections = node['android:protectionLevel'].split('|')

    @protection = {
        :system => protections.include?('system'),
        :signature => protections.include?('signature'),
        :dangerous => protections.include?('dangerous'),
        :normal => protections.include?('normal')
    }

  end

  def name
    unless @name.nil? || @name.empty?
      return @name
    end
    @id
  end

  def group
    @group
  end

  def id
    @id
  end

  def description
    @description
  end

  def to_s
    @name
  end

  def protected? (level)
    @protection[level]
  end

  def protection_string
    out = []
    @protection.each do |level, protected|
      if protected
         out.push level.to_s
      end
    end
    out.join ', '
  end

end