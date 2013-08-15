require 'yaml'
require 'ERB'

class Generator
  def initialize(lang)
    @lang = lang
    @copy = YAML.load_file('.text.yml')
  end

  def t(key)
    @copy[key][@lang]
  end

  def html_result
    ERB.new(File.open(".template.html.erb").read).result(binding)
  end
end

puts Generator.new(ARGV[0]).html_result