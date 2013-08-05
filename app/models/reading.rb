require 'mongo'
require 'uri'

class Reading
  def self.latest_readings
    db = get_connection
    coll = db.collection('readings')

    coll.aggregate([
                       {"$match" => {mobileId: {"$in" => ['4531019793','4531010358','4531010353','4531004944']}}},
                       {"$sort" => {updateTime: 1}},
                       {"$group" => {_id: "$mobileId", latest: {"$last" => "$geo"}}}
                   ]).map {|r| {"#{r['_id']}" => r['latest']['coordinates']}}
  end

  def self.get_connection
    return @db_connection if @db_connection
    db = URI.parse('mongodb://adhd360:5tekapU3@dharma.mongohq.com:10071/gateway')
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    @db_connection
  end

  def self.where(params)
    db = get_connection
    coll = db.collection('readings')

    coll.find(params)
  end
end