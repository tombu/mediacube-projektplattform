class Statustemplate < ActiveRecord::Base
  def self.substitute subKey, subHash = Hash.new
    @tmpl = Statustemplate.find_by_key subKey
    subHash.each do |key, str|
      @tmpl.template.gsub! key, str
    end
    @tmpl.template
  end
end
