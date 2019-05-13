require 'pry'
require_relative "./item.rb"
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #binding.pry
    if req.path.match(/items/)
      #binding.pry
      resp.write "You requested the items"
      item_name = req.path.split("/items/").last
      item = @@items.find do |i|
        i.name == item_name
      end

      if item == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
