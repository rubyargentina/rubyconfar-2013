#!/usr/bin/env ruby

require 'yaml'
require 'ERB'

class Generator
  def initialize(lang)
    @lang = lang
    @text = YAML.load_file(".text_#{lang}.yml")
    @speakers = YAML.load_file(".speakers_#{lang}.yml")
  end

  def t(key)
    @text[key]
  end

  def html_result
    write_html @lang + '/index.html', ERB.new( File.open(".template.html.erb").read ).result(binding)
    write_html @lang + '/program.html', ERB.new( File.open(".program.html.erb").read ).result(binding)
  end

private
  def write_html(file, html)
    File.open(file, 'w'){|f| f.write html}
  end
end

if ARGV[0].nil?
  printf "usage: %s [en|es]\n", $0
  exit
end

puts Generator.new(ARGV[0]).html_result
