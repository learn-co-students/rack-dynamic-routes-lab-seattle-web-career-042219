require 'pry'

class Application
  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      resp.write "path is items"
      item_name = req.path.split('/items/').last
      if Item.all.find{|x| x.name == item_name}==nil
        resp.write "Item not found"
        resp.status=400
      else
        price = Item.all.find{|x| x.name == item_name}
      resp.write "#{price.price}"
    end 
    else
      resp.write "Route not found"
      resp.status=404
    end
    resp.finish
  end
end
