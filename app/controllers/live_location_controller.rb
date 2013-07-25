require 'mongo'
require 'uri'

class LiveLocationController < ApplicationController
  def index
    @devices = Device.all
    @car_names = {}
    @devices.each {|d| @car_names["#{d['id']}"] = "#{d['name']}"}
    @latest_readings = latest_readings
  end

  private
  def latest_readings
    db = get_connection
    coll = db.collection('readings')

    coll.aggregate([
                       {"$match" => {mobileId: {"$in" => ['4531019793','4531010358','4531010353','4531004944']}}},
                       {"$sort" => {updateTime: 1}},
                       {"$group" => {_id: "$mobileId", latest: {"$last" => "$geo"}}}
                   ]).map {|r| {"#{r['_id']}" => r['latest']['coordinates']}}
  end

  def get_connection
    return @db_connection if @db_connection
    db = URI.parse('mongodb://adhd360:5tekapU3@dharma.mongohq.com:10071/gateway')
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    @db_connection
  end
end
