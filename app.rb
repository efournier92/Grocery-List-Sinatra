require 'sinatra'
require 'pg'
require 'pry'

configure :development do
  set :db_config, { dbname: 'grocery_list_development' }
end

configure :test do
  set :db_config, { dbname: 'grocery_list_test' }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

def groceries_lister
  db_connection do |conn|
    sql_query = "SELECT * FROM groceries"
    conn.exec(sql_query)
  end
end

def new_item_saver(params)
  unless params[:name].empty?
    db_connection do |conn|
      sql_query = "INSERT INTO groceries (name) VALUES ($1)"
      data = [params[:name]]
      conn.exec_params(sql_query, data)
    end
  end
end

def items_getter(id)
  db_connection do |conn|
    sql_query = %(
      SELECT *
      FROM groceries
      WHERE groceries.id = ($1)
    )
    data = [id]
    conn.exec_params(sql_query, data)
  end
end

def item_saver(params)
  db_connection do |conn|
    sql_query = 'INSERT INTO groceries (body, grocery_id)
    VALUES ($1, $2)'
    data = [params[:body], params[:grocery_id]]
    conn.exec_params(sql_query, data)
  end
end

def grocery_item_getter(id)
  sql_query = %(
  SELECT groceries.*, comments.*
  FROM groceries
  FULL JOIN comments ON groceries.id = comments.grocery_id
  WHERE groceries.id = ($1)
  )
  db_connection do |conn|
    data = [id]
    conn.exec_params(sql_query, data)
  end
end

def comments_lister(id)
  db_connection do |conn|
    sql_query = %(
    SELECT groceries.*, comments.* FROM groceries
    JOIN comments ON groceries.id = comments.grocery_id
    WHERE groceries.id = $1"
    )
    data = [id]
    conn.exec_params(sql_query, data)
  end
end

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  @groceries = groceries_lister

  erb :groceries
end

post "/groceries" do
  new_item_saver(params)
  redirect "/groceries"
end

get "/groceries/:id" do
  @grocery_items = items_getter(params[:id]).first
  @item_name = @grocery_items ['name']

  @items = grocery_item_getter(params[:id])

  erb :show_item_details
end

post "/groceries/:id" do
  save_items(params)
  redirect '/groceries'
end
