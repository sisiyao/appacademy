require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params, :protect

  # Setup the controller
  def initialize(req, res, route_params = {})
    @params = req.params.merge(route_params)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "double render error" if already_built_response?
    @res['Location'] = url
    @res.status = 302
    @already_built_response = true
    session.store_session(@res)
    flash.store_flash(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "double render error" if already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = true
    session.store_session(@res)
    flash.store_flash(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore
    curr_dir = File.expand_path(File.dirname(__FILE__))
    path_to_template = "#{curr_dir}/../views/#{controller_name}/#{template_name}.html.erb"

    template_code = File.read(path_to_template)
    erb_contents = ERB.new(template_code).result(binding)

    render_content(erb_contents, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    p name != :get
    p @@protect
    if name != :get && @@protect == true
      p "here"
      p check_authenticity_token
      raise Exception unless check_authenticity_token
    end

    self.send(name.to_sym)
    unless already_built_response?
      render(name)
    end
  end

  def form_authenticity_token
    @token ||= SecureRandom.urlsafe_base64(32)
    session['authenticity_token'] ||= @token
  end

  def check_authenticity_token
    params[:authenticity_token] == session['authenticity_token']
  end

  def self.protect_from_forgery
    @@protect = true
  end
end
