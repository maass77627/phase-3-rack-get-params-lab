class Application
  @@cart = []
   @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

      elsif req.path.match(/cart/)
        if  @@cart.empty? 
          resp.write "Your cart is empty" 
        else
          @@cart.each do |item|
            resp.write "#{item}\n"
          end
        end
       resp.write handle_cart

       elsif req.path.match(/add/)
        added_item = req.params["item"]
        resp.write handle_add(added_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(item)
    if @@items.include?(item)
      @@cart << item
      return "added #{item}"
    else 
      return "We don't have that item"
  end
end

  def handle_cart
  if  @@cart.empty? 
    return "Your cart is empty" 
  else
    @@cart.each do |item|
      return "#{item}\n"
    end
  end
  end

end
