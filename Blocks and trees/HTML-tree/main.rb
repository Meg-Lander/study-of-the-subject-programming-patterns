require_relative 'html_tree'
require_relative 'tag'

file_path = 'index.html'
html_tree = HTML_tree.new(file_path)

puts html_tree

puts "\nОбход в ширину:"
html_tree.breadth_first_each { |tag| puts tag.short_info }

puts "\nТеги, у которых есть атрибуты:"
tags_with_attributes = html_tree.select { |tag| tag.has_attributes? }
tags_with_attributes.each { |tag| puts tag.tag_name }

puts "\nТеги с наименьшим и с наибольшим количеством детей:"
tags_with_min_max_children = html_tree.minmax
puts "Тег с наименьшим количеством детей: #{tags_with_min_max_children.first.tag_name}"
puts "Тег с наибольшим количеством детей: #{tags_with_min_max_children.last.tag_name}"