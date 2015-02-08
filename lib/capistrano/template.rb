def smart_template(from, to=nil)
  to ||= from
  full_to_path = "#{shared_path}/config/#{to}"

  if from_erb_path = template_file(from)
    from_erb = StringIO.new(ERB.new(File.read(from_erb_path)).result(binding))
    upload! from_erb, full_to_path
    info "copying: #{from_erb} to: #{full_to_path}"
  else
    error "error #{from} not found"
  end
end

def sub_strings(input_string)
  output_string = input_string

  input_string.scan(/{{(\w*)}}/).each do |var|
    output_string.gsub!("{{#{var[0]}}}", fetch(var[0].to_sym))
  end

  output_string
end

def template_file(name)
  if File.exist?((file = "config/deploy/#{fetch(:full_app_name)}/#{name}.erb"))
    file
  elsif File.exist?((file = "config/deploy/shared/#{name}.erb"))
    file
  end
end
