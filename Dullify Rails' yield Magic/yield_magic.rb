require "erubi"

def render(template)
  render_with_layout do
    render_template(template)
  end
end

def render_with_layout(layout = nil)
  default_layout = layout || <<-END
    <head>... lots of heady stuff </head>
    <body>
      #{yield}
    </body>
  END
  eval(Erubi::Engine.new(default_layout).src)
end

def render_template(partial_name)
  eval(Erubi::Engine.new(File.read("#{partial_name.to_s}.html.erb")).src)
end

template = render_with_layout { render_template(:index) }

puts template
