#!/usr/bin/env ruby

require 'yaml'
require 'ERB'

class Generator
  def initialize(lang)
    @lang = lang
    @text = YAML.load_file(".text_#{lang}.yml")
    @speakers = YAML.load_file(".speakers_#{lang}.yml")
    @rfd_speakers = YAML.load_file(".rfd_speakers_#{lang}.yml")
  end

  def t(key)
    @text[key]
  end

  def html_result
    write_html @lang + '/index.html', ERB.new( File.open(".index.html.erb").read ).result(binding)
    write_html @lang + '/program.html', ERB.new( File.open(".program.html.erb").read ).result(binding)
    write_html @lang + '/rfd.html', ERB.new( File.open(".rfd.html.erb").read ).result(binding)
    write_html @lang + '/schedule.html', ERB.new( File.open(".schedule.html.erb").read ).result(binding)
    write_html @lang + '/app.html', ERB.new( File.open(".app.html.erb").read ).result(binding)
  end

  def schedule_talk(id, rfd = false)
    if rfd
      "<a href=\"rfd.html##{id}\">#{@rfd_speakers[id]['title']}</a><span>#{@rfd_speakers[id]['full_name']}</span>"
    else
      "<a href=\"program.html##{id}\">#{@speakers[id]['title']}</a><span>#{@speakers[id]['full_name']}</span>"
    end
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
