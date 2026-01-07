# Generate an llms.txt as per https://llmstxt.org/.
#
class LlmsTxtExtension < Middleman::Extension
  def after_build(_builder)
    build_dir = app.root_path.join(app.config[:build_dir])

    copy_app_files(build_dir)
    copy_api_files(build_dir)
  end

  private

  def copy_app_files(build_dir)
    output_dir = build_dir.join("apps")
    FileUtils.mkdir_p(output_dir)

    copy_app_partials(output_dir)
    copy_schema_docs(output_dir)
  end

  def copy_app_partials(output_dir)
    %w[general capabilities].each do |subdir|
      pattern = app.root_path.join("source", "includes", "apps", subdir, "_*.md")
      Dir.glob(pattern).each { |path| copy_partial(path, output_dir) }
    end
  end

  def copy_schema_docs(output_dir)
    pattern = app.root_path.join("source", "includes", "schemas", "*.md")
    Dir.glob(pattern).each { |path| copy_partial(path, output_dir) }
  end

  def copy_api_files(build_dir)
    output_dir = build_dir.join("api")
    FileUtils.mkdir_p(output_dir)

    copy_api_partials(output_dir)
    append_api_links_to_llms_txt(build_dir)
  end

  def copy_api_partials(output_dir)
    pattern = app.root_path.join("source", "includes", "v4", "resources", "_*.md")
    Dir.glob(pattern).sort.each { |path| copy_partial(path, output_dir) }
  end

  def copy_partial(source_path, output_dir)
    filename = File.basename(source_path).sub(/^_/, "")
    FileUtils.cp(source_path, output_dir.join(filename))
    puts "        \e[1;32mcopy\e[0m  #{output_dir.basename}/#{filename}"
  end

  def append_api_links_to_llms_txt(build_dir)
    llms_txt_path = build_dir.join("llms.txt")
    pattern = app.root_path.join("source", "includes", "v4", "resources", "_*.md")

    links = Dir.glob(pattern).sort.map do |source_path|
      filename = File.basename(source_path).sub(/^_/, "")
      title = filename.sub(/\.md$/, "").split("_").map(&:capitalize).join(" ")
      "- [#{title}](https://developers.booqable.com/api/#{filename})"
    end

    section = <<~MARKDOWN


      ## API Resources

      #{links.join("\n")}
    MARKDOWN

    File.open(llms_txt_path, "a") { |f| f.write(section) }
    puts "      \e[1;32mappend\e[0m  API Resources section to llms.txt"
  end
end

::Middleman::Extensions.register(:llms_txt, LlmsTxtExtension)

