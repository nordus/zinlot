require 'mongo'
require 'uri'
require 'nokogiri'
require 'open-uri'

class Reading

  def self.scrape_dtc_description(code)
    doc = Nokogiri::HTML(open("http://www.obd-codes.com/#{code}"))
    bulletLists = doc.css('.KonaBody ul')

    return({
        description: doc.css('title')[0].text,
        causes: bulletLists[0].to_html.gsub!(/\s+/, ' '),
        solutions: bulletLists[1].to_html.gsub!(/\s+/, ' ')
    })
  end

  def self.dtc_description(dtc_code)
    @dtc_descriptions ||= {}

    return @dtc_descriptions[dtc_code]  if @dtc_descriptions[dtc_code]

    @dtc_descriptions[dtc_code] = scrape_dtc_description(dtc_code)
    return @dtc_descriptions[dtc_code]
  end

  def self.latest_readings(mobile_ids: ['4531010358','4531010353','4531004944'])
    db = get_connection
    coll = db.collection('readings')

    coll.aggregate([
                       {"$match" => {mobileId: {"$in" => mobile_ids}}},
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

  def self.find_one(params)
    db = get_connection
    coll = db.collection('readings')

    coll.find(params).sort(updateTime: :desc).limit(1).first
  end
end