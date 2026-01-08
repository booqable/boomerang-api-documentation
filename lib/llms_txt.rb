# Generate an llms.txt as per https://llmstxt.org/.
#
class LlmsTxtExtension < Middleman::Extension

  def after_build(_builder)
    build_dir = app.root_path.join(app.config[:build_dir])

    copy_app_files(build_dir)
    copy_api_files(build_dir)
  end

  private

  def includes_dir
    app.root_path.join("source", "includes")
  end

  def copy_app_files(build_dir)
    output_dir = build_dir.join("apps")
    FileUtils.mkdir_p(output_dir)

    copy_app_partials(output_dir)
    copy_schema_docs(output_dir)
  end

  def copy_app_partials(output_dir)
      includes_dir
        .glob("apps/{general,capabilities}/_*.md")
        .reject { |path| path.basename.to_s.match?(/intro\.md$/) }
        .each { |path| copy_partial(path, output_dir) }
  end

  def copy_schema_docs(output_dir)
    includes_dir
      .glob("schemas/*.md")
      .each { |path| copy_partial(path, output_dir) }
  end

  def copy_api_files(build_dir)
    output_dir = build_dir.join("api")
    FileUtils.mkdir_p(output_dir)

    copy_api_intro_partials(output_dir)
    copy_api_resource_partials(output_dir)
    append_api_links_to_llms_txt(build_dir)
  end

  def copy_api_intro_partials(output_dir)
    includes_dir
      .glob("v4/_{introduction,authentication,errors}.md")
      .each { |path| copy_partial(path, output_dir) }
  end

  def copy_api_resource_partials(output_dir)
    includes_dir
      .glob("v4/resources/*.md")
      .each { |path| copy_partial(path, output_dir) }
  end

  def copy_partial(path, output_dir)
    filename = File.basename(path).sub(/^_/, "")
    FileUtils.cp(path, output_dir.join(filename))
    puts "        \e[1;32mcopy\e[0m  #{output_dir.basename}/#{filename}"
  end

  def append_api_links_to_llms_txt(build_dir)
    llms_txt_path = build_dir.join("llms.txt")
    resource_partials = includes_dir.glob("v4/resources/*.md").sort

    make_md_link = ->(path) do
      filename = File.basename(path).sub(/^_/, "")
      title = filename.sub(/\.md$/, "").split("_").map(&:capitalize).join(" ")

      "- [#{title}](https://developers.booqable.com/api/#{filename})"
    end

    section = <<~MARKDOWN


      ## API Resources

      #{resource_partials.map(&make_md_link).join("\n")}
    MARKDOWN

    File.open(llms_txt_path, "a") { |f| f.write(section) }
    puts "      \e[1;32mappend\e[0m  API Resources section to llms.txt"
  end

end

::Middleman::Extensions.register(:llms_txt, LlmsTxtExtension)

