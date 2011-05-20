# coding: utf-8
require 'sinatra'
require 'json'
require 'erb'

#require 'coffee-script'
require 'geo-triangle'

get '/' do
  erb :index
end

post '/g' do
  nums = []
  [:geo1lat, :geo1lon, :geo2lat, :geo2lon, :geo3lat, :geo3lon].each do |name|
    n = to_geonum(params[name])
    nums << n if n
  end
  c = get_center(nums)
  target = c ? "/m/#{nums.map{|n| geo_num(n)}.join(',')}" : "/"
  redirect target
end

#get '/app.js' do
#  coffee :app
#end

get '/m/:query' do
  @coordinates = split_query(params[:query])
  @center = get_center(@coordinates)
  erb :map
end

get '/c/:query' do
  ret = {}
  begin
    query = split_query(params[:query])
    center = get_center(query)
    if center
      ret[:lat] = center.first
      ret[:lon] = center.last
    end
  rescue
    # return empty hash
  end
  ret.to_json
end

helpers do

  # これ自動で判別できないか・・・？
  configure :production do
    set :app_path, '/gt'
  end

  configure :development do
    set :app_path, ''
  end

  def app_path
    options.app_path
  end

  def to_geonum(s)
    n = s[/^(\d{1,3}\.\d{1,8})$/, 1]
    n ? BigDecimal(n) : nil
  end

  def split_query(q)
    return [] unless q
    q.split(',').map{|s| to_geonum(s)}.compact
  end

  def get_center(nums)
    return if nums.empty?
    GeoTriangle.center(nums)
  end

  def geo_num(n)
    return unless n
    n.round(6).to_f
  end

end

