require 'json'
require 'byebug'

class Flash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    if cookie
      @curr_flash_data = JSON.parse(cookie)
    else
      @curr_flash_data = {}
    end

    @new_flash_data = {}
  end

  def [](key)
    @curr_flash_data[key]
  end

  def []=(key, val)
    @curr_flash_data[key] = val
    @new_flash_data[key] = val
  end

  def now
    @curr_flash_data
  end

  def store_flash(res)
    cookie_attributes = {
      path: "/",
      value: @new_flash_data.to_json
    }
    res.set_cookie("_rails_lite_app_flash", cookie_attributes.to_json)
  end
end
