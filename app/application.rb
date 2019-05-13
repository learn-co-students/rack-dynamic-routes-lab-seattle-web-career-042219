class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = @@items.find { |item| item.name == req.path.split("/items/").last }
      if item == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write "#{item.price}"
        resp.status = 200
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
