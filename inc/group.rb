module Group

  def name
    @name
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

  def add_permission(permission)
    @permissions[permission.id] = permission
  end

  def permissions
    @permissions
  end

end