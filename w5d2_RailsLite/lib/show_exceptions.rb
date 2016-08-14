require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue Exception => e
    # this is the version that passes the specs
    # ['500', {'Content-type' => 'text/html'}, [render_exception(e)]]

    # req = Rack::Request.new(env)
    res = Rack::Response.new
    res['Content-Type'] = 'text/html'
    res.status = 500
    res.write(render_exception(e))
    res.finish
  end

  private

  def render_exception(e)
    # this is the version that passes the specs
    # e.message

    <<-ERROR
      Error: #{e.message}<br><br>
      Backtrace:<br><p>#{e.backtrace.join("<br>")}</p>
      Source code:<br><p>
        #{source_code(e)}
      </p>
    ERROR
  end

  def source_code(e)
    backtrace_file_line = e.backtrace[1]
    file_dir = /.*\.rb/.match(backtrace_file_line).to_s
    line_num = /\.rb:\d+/.match(backtrace_file_line).to_s[4..-1].to_i
    file_lines = File.readlines(file_dir)

    <<-SOURCE
      #{file_lines[line_num - 3, line_num - 1].join("<br>")}
      ERROR***#{file_lines[line_num]}
      #{file_lines[line_num + 1, line_num + 3].join("<br>")}
    SOURCE
  end

end
