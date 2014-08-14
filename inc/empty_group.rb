require_relative 'group.rb'

class EmptyGroup

  include Group

  def initialize()
    @id = 'none'
    @name = 'No Group'
    @description = 'No Group Provided'
    @permissions = {}
  end

end