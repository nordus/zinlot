require 'open-uri'
require 'json'


class Geofence

  def self.is_boundary(geofence_id)
    boundaries[String(geofence_id)]
  end

  def self.boundaries
    return @boundaries if @boundaries

    spreadsheet_url = 'https://script.googleusercontent.com/macros/echo?user_content_key=9jo2erGNd3OfAIwxTngNOvdZGibZdqOHgm-v3xG-StJlDPaRfvHhfhseRCykkliBebkkPO1_lbgUk-lbo2KawgJ-PB5PRUKrm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIg7dwLxLX18MUmaELArO_eA6aas-1v5uSuWsenhW_qh2ErxpA9KyIWoicc3BPw-wScfNc2fO4hD&lib=Mo1V62sgeaAcmBiQ5a2NZjEksqmD0cRi9'
    @boundaries = JSON.parse(open(spreadsheet_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    return @boundaries
  end

  def self.friendly_name(geofence_id)
    friendly_names[String(geofence_id)]
  end

  def self.friendly_names
    return @friendly_names if @friendly_names

    spreadsheet_url = 'https://script.googleusercontent.com/macros/echo?user_content_key=zuCvHbw73t3JUpR0mQte2WrRbHVNXWKoGvtF6ih4v_CuMZ87kOi8F_LfBj-EPQWpJRVfIL0M0WJKo58cSiDDFP5pNBWQWUwem5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnOzpDlJgm0n4rWBCKLKK76OwTNvBeNH5pHHfM10H582pPVIj0ngg9zxGM0VaeRCJu2Bel-zImZlo&lib=Mh0VmzieLjAbAoUBWSkDdXopdPpql0DA_'
    @friendly_names = JSON.parse(open(spreadsheet_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    return @friendly_names
  end
end