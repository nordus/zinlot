require 'nokogiri'
require 'open-uri'

class DtcCodesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  before_filter :allow_cors

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
        %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

    head(:ok) if request.request_method == "OPTIONS"
    # or, render text: ''
    # if that's more your style
  end

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