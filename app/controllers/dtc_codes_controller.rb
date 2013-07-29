require 'nokogiri'
require 'open-uri'

class DtcCodesController < ApplicationController

  respond_to :json

  def show
    doc = Nokogiri::HTML(open("http://www.obd-codes.com/#{params[:code]}"))
    bulletLists = doc.css('.KonaBody ul')

    respond_with({
      description: doc.css('title')[0].text,
      causes: bulletLists[0].to_html.gsub!(/\s+/, ' '),
      solutions: bulletLists[1].to_html.gsub!(/\s+/, ' ')
                 })
  end
end