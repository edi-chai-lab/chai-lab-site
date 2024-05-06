require 'bibtex'
require 'yaml'

b = BibTeX.open('_data/references.bib')
Dir.glob("papers/_posts/*.md").each { |file| File.delete(file)
puts file}

b.each { |x| y = x.to_hash
  y[:layout] = 'paper'
  if y[:author].length > 1
    ref = x.author[0][1].to_s + " et. al, " + x.year.to_s
  else
    ref = x.author[0][1].to_s +", " + x.year.to_s
  end
  y[:ref] = ref

  y.transform_values { |value| '"' + value.to_s + '"'}
  y = y.transform_keys(&:to_s)
  y["external_url"] = y.delete "url" if y.key?("url")
  y = y.to_yaml.tr('{}', '')
  y = y + '---'

  f_name = "papers/_posts/"+x.year.to_s+"-01-01"+"-"+x.title.to_s.tr('\"{}', '').tr(' ', '-')+".md"
  puts f_name

  puts y
  File.write(f_name, y)
 }
