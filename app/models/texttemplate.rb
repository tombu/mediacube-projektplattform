class Texttemplate < ActiveRecord::Base
  def self.substitute subKey, subHash = Hash.new
    @tmpl = Texttemplate.find_by_key subKey
    subHash.each do |key, str|
      @tmpl.text.gsub! key, str
    end
    @tmpl.text
  end
end
