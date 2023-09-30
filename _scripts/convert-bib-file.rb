require 'bibtex'
require 'yaml'

b = BibTeX.open('_data/references.bib')

b.each { |x| y = x.to_hash
  y[:layout] = 'paper'
  if y[:author].length > 1
    ref = x.author[0][1].to_s + " et. al, " + x.year.to_s
  else
    ref = x.author[0][1].to_s +", " + x.year.to_s
  end
  y[:ref] = ref
  f_name = "papers/_posts/01-01-"+x.year.to_s[-2..-1]+"-"+x.title.to_s.split[0]+".md".tr('\"{}', '')
  puts f_name
  y = y.transform_keys(&:to_s).to_yaml
  y = y.tr('\"{}', '')
  y = y + '---'
  File.write(f_name, y)
 }
