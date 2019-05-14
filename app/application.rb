class Application

	@@item = []

	def call(env)
		resp = Rack::Response.new
		req = Rack::Request.new(env)
		if req.path.match(/items/)
			item_name = req.path.split("/").last
			item = Item.all.find do |item| item.name == item_name end
			if item 
				resp.status = 200
				resp.write "#{item.price}"
			else
				resp.status = 400
				resp.write "Item not found"
			end
		else
			resp.status = 404
			resp.write "Route not found"
		end
	resp.finish
	end
end