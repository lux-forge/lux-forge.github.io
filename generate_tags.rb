require 'yaml'

tags = Dir.glob("_posts/*.md").flat_map do |file|
  content = File.read(file)
  if content =~ /---\s*\n(.*?)\n---/m
    front_matter = YAML.load($1)
    front_matter['tags'] || []
  else
    []
  end
end.uniq

tags.each do |tag|
  slug = tag.downcase.strip.gsub(' ', '-')
  path = "tags/#{slug}.md"
  next if File.exist?(path)

  File.write(path, <<~MARKDOWN)
    ---
    layout: tag_index
    tag: #{slug}
    title: "#{tag} Posts and Incidents"
    permalink: /tags/#{slug}/
    ---
  MARKDOWN

  puts "Generated: #{path}"
end