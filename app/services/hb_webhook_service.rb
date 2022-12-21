require "httparty"

class HbWebhookService
  include HTTParty
  format :json
  base_uri ENV['GASPAR_HOMEBRIDGE_WEBHOOK_URL']
  basic_auth  ENV['GASPAR_HOMEBRIDGE_WEBHOOK_USERNAME'], ENV['GASPAR_HOMEBRIDGE_WEBHOOK_PASSWORD']

  NIGHTY_NIGHT_SWITCH_ID = 'nighty-night-switch'

  def set_nighty_night(isOn)
    res = self.class.get("?accessoryId=#{NIGHTY_NIGHT_SWITCH_ID}&state=#{isOn}")
    puts res
  end
end