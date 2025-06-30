require "json"
require "stringio"

JSONSchema = Struct.new(:properties, :definitions, keyword_init: true)
Property = Struct.new(:name, :type, :description, :required, :examples, :const, :enum, :format, :items, :ref, keyword_init: true)
Definition = Struct.new(:name, :schema, keyword_init: true)

class JSONSchemaParser

  def self.parse(schema_text)
    schema_data = JSON.parse(schema_text)

    parse_schema(schema_data)
  end

  def self.parse_schema(hash, definitions = [])
    (hash["definitions"] || {}).each do |name, hash|
      definitions << Definition.new(name:, schema: parse_schema(hash, definitions))
    end
    required_properties = hash["required"] || []
    properties = parse_properties(hash["properties"] || {}, required_properties)

    JSONSchema.new(properties:, definitions:)
  end

  def self.parse_properties(properties_hash, required_properties)
    properties_hash.map do |name, prop_data|
      Property.new(
        name: name,
        type: prop_data["type"],
        description: prop_data["description"],
        required: required_properties.include?(name),
        examples: prop_data["examples"],
        const: prop_data["const"],
        enum: prop_data["enum"],
        format: prop_data["format"],
        items: prop_data["items"],
        ref: prop_data["$ref"]
      )
    end
  end

end

module MarkdownGenerator

  def self.generate_from(schema_source)
    schema = case schema_source
      when JSONSchema then schema_source
      when String then JSONSchemaParser.parse(schema_source)
      when IO, StringIO then JSONSchemaParser.parse(schema_source.read)
      else
        raise "Unsupported schema source: #{schema_source.class}"
      end

    generate(schema)
  end

  def self.generate(schema)
    buffer = StringIO.new

    generate_preamble(buffer)
    generate_schema_section(buffer, schema, "`/config/meta.json`")
    schema.definitions.each do |definition|
      generate_schema_section(buffer, definition.schema, "`#{definition.name}`")
    end

    buffer.string
  end

  def self.generate_preamble(buffer)
    buffer.puts "# Reference"
    buffer.puts
  end

  def self.generate_schema_section(buffer, schema, header)
    buffer.puts "## #{header}"
    buffer.puts
    generate_example_json(buffer, schema)
    generate_properties_table(buffer, schema)
  end

  def self.generate_example_json(buffer, schema)
    buffer.puts "```json"
    buffer.puts "{"
    schema.properties.each do |property|
      indentation = "  "
      buffer.write indentation, '"', property.name, '": '
      generate_example_value(buffer, property, indentation:)
      buffer.puts (property == schema.properties.last ? "" : ",")
    end
    buffer.puts "}"
    buffer.puts "```"
    buffer.puts
  end

  def self.generate_example_value(buffer, property, indentation:)
    if property.ref
      buffer.write '{ /* ', property.ref.split("/").last, ' */ }'
    else
      example_value = if property.const
        property.const
      elsif property.enum && property.enum.any?
        property.enum.first
      elsif property.examples && property.examples.any?
        property.examples.first
      end

      case property.type
      when "string"
        example_value ||= if property.format == "email"
          "support@example.com"
        elsif property.format == "uri"
          "https://example.com"
        else
          "lorem ipsum"
        end
        buffer.write '"', example_value, '"'
      when "number", "integer"
        example_value ||= 42
        buffer.write example_value
      when "boolean"
        buffer.write "true"
      when "array"
        buffer.write "[ /* ... */ ]"
      when "object"
        buffer.write "{ /* ... */ }"
      else
        puts property.inspect
        raise "Don't know how to generate example value for #{property.type}"
      end
    end
  end

  def self.generate_properties_table(buffer, schema)
    return if schema.properties.empty?

    buffer.puts "| Name | Type | Required | Description |"
    buffer.puts "|------|------|----------|-------------|"

    schema.properties.each do |property|
      type = get_type_description(property)
      required = property.required ? "true" : "false"
      description = property.description || ""

      # Escape pipe characters in description to prevent table breaking
      description = description.gsub("|", '\\|')

      buffer.puts "| `#{property.name}` | #{type} | #{required} | #{description} |"
    end
  end

  def self.get_type_description(property)
    if property.ref
      ref_name = property.ref.split("/").last
      "[`#{ref_name}`](#reference-#{ref_name.downcase})"
    elsif property.type == "array" && property.items
      if property.items["$ref"]
        ref_name = property.items["$ref"].split("/").last
        "array of [`#{ref_name}`](##{ref_name.downcase})"
      else
        "array of #{property.items["type"]}"
      end
    elsif property.enum
      "one of: `#{property.enum.join("`, `")}`"
    else
      property.type
    end
  end

end

class JSONSchemaMarkdownGenerator

  def initialize(output_dir:, root: Pathname.getwd, cache: {}, log: STDOUT)
    @root = Pathname(root)
    @output_dir = Pathname(output_dir)
    @cache = cache
    @log = log
  end

  def generate_markdown_for_json_schema(schema_relative_path)
    schema_relative_path = Pathname(schema_relative_path)
    schema_absolute_path = @root.join(schema_relative_path)
    schema_text = schema_absolute_path.read
    schema_digest = Digest::MD5.hexdigest(schema_text)

    markdown_filename = schema_relative_path.basename.sub_ext('.md')
    markdown_relative_path = @output_dir.join(markdown_filename)
    markdown_absolute_path = @root.join(markdown_relative_path)

    cache_key = [schema_relative_path, schema_digest]
    cached_markdown_digest = @cache[cache_key]
    markdown_file_exists = markdown_absolute_path.exist?
    existing_markdown_digest = Digest::MD5.hexdigest(markdown_absolute_path.read) if markdown_file_exists

    if markdown_file_exists && existing_markdown_digest == cached_markdown_digest
      return
    else
      markdown_text = MarkdownGenerator.generate_from(schema_text)

      markdown_absolute_path.write(markdown_text)
      @cache[cache_key] = Digest::MD5.hexdigest(markdown_text)
      @log.puts "   📝 generated #{markdown_relative_path}"
    end
  end

  def self.generate_markdown_for_json_schema(schema_relative_path, output_dir:, root: Pathname.getwd, log: STDOUT)
    JSONSchemaMarkdownGenerator.new(output_dir:, root:, log:)
      .generate_markdown_for_json_schema(schema_relative_path)
  end

end

class JSONSchemaMarkdownGeneratorExtension < Middleman::Extension

  option :output_dir

  def initialize(...)
    super(...)
    @generator = JSONSchemaMarkdownGenerator.new(output_dir: options.output_dir)
  end

  def ready
    generate_markdown_for_json_schemas
  end

  private

  def generate_markdown_for_json_schemas
    json_schemas.each do |resource|
      schema_path = Pathname("source").join(resource.path)
      @generator.generate_markdown_for_json_schema(schema_path)
    end
  end

  def json_schemas
    app.sitemap.resources.filter{ _1.path.match?(%r{schemas/.*\.json}) }
  end
end
