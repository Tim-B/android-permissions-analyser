module AndroidXML

  def find_string(id)
    if id.nil?
      return ''
    end
    search_val = remove_prefix id
    @labels.xpath('//resources/string[@name="' + search_val + '"]').first.content
  end

  def remove_prefix(string)
    string.slice! '@string/'
    string
  end
end