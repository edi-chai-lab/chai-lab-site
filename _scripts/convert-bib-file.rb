require 'bibtex'
require 'yaml'
require 'fileutils'

b = BibTeX.open('_data/references.bib')

FileUtils.rm_rf("papers/_posts/.", secure: true)
b.each { |x| y = x.to_hash
  y[:layout] = 'paper'
  if y[:author].length > 1
    ref = x.author[0][1].to_s + " et. al, " + x.year.to_s
  else
    ref = x.author[0][1].to_s +", " + x.year.to_s
  end
  y[:ref] = ref
  f_name = "papers/_posts/01-01-"+x.year.to_s[-2..-1]+"-"+x.title.to_s.tr('\"{}', '').tr(' ', '-')+".md"
  puts f_name
  y.transform_values { |value| '"' + value.to_s + '"'}
  y = y.transform_keys(&:to_s).to_yaml
  y = y.tr('{}', '')
  y = y + '---'
  File.write(f_name, y)
 }
