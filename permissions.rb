require 'nokogiri'
require_relative 'inc/permission.rb'
require_relative 'inc/permission_group.rb'
require_relative 'inc/empty_group.rb'

doc = Nokogiri::XML(open('permissions_analyser/AndroidManifest.xml'))
labels = Nokogiri::XML(open('permissions_analyser/res/values/strings.xml'))

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
  colorize(text, 31)
end

def green(text)
  colorize(text, 32)
end

permGroups = {
    'none' => EmptyGroup.new
}

protectionCount = {
    :system => 0,
    :signature => 0,
    :dangerous => 0,
    :normal => 0
}

total = 0

doc.css('permission-group').each do |group|
  new_group = PermissionGroup.new group, labels
  permGroups[new_group.id] = new_group
end

doc.css('permission').each do |permission|
  new_permission = Permission.new permission, labels

  unless permGroups[new_permission.group].nil?
    permGroups[new_permission.group].add_permission new_permission
  else
    permGroups['none'].add_permission new_permission
  end

  protectionCount.each do |protection, count|
    if new_permission.protected? protection
      protectionCount[protection] += 1
    end
  end

  total += 1

end

permGroups.each do |group_id, group|
  puts '============ ' + group.name + ' ============ '

  group.permissions.each do |perm_id, perm|
    line = perm.name + ' : ' + perm.protection_string
    if perm.protected?(:dangerous) || perm.protected?(:normal)
      puts red line
    else
      puts line
    end
  end
  puts ''
end

puts '===== Totals ====='
puts 'System: ' + protectionCount[:system].to_s
puts 'Signature: ' + protectionCount[:signature].to_s
puts 'Dangerous: ' + protectionCount[:dangerous].to_s
puts 'Normal: ' + protectionCount[:normal].to_s
puts 'Total: ' + total.to_s
puts '=================='
