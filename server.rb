require "sinatra"
require "csv"
require "pry"

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  @groceries = CSV.readlines("grocery_list.csv", headers: true)
  
  erb :index
end

post "/groceries" do
  new_item_name     = params["Name"]
  new_item_quantity = params["Quantity"]

  unless new_item_name.strip.empty?
    CSV.open("grocery_list.csv", "a", headers: true) do |file|
      if new_item_quantity.empty?
        file.puts([new_item_name])
      else
        file.puts([new_item_name, new_item_quantity])
      end
    end
  end
  redirect "/groceries"
end


get '/groceries/:grocery_item' do
  @item      = params[:grocery_item]
  @groceries_array = CSV.readlines("grocery_list.csv", headers: true).to_a

  erb :grocery_item
end
