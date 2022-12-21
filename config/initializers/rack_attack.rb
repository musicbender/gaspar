class Rack::Attack
  Rack::Attack.enabled = ENV['GASPAR_ENABLE_RACK_ATTACK'] || Rails.env.production?
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  throttle_limit = ENV.fetch('GASPAR_THROTTLE_LIMIT') { 20 }

  throttle('req/ip', limit: throttle_limit.to_i, period: 1.minutes) do |req|
    req.ip
  end

  Rack::Attack.blocklist("mark any unauthenticated access unsafe") do |request|
    request.env["HTTP_APIKEY"] != ENV['GASPAR_API_KEY'] 
  end

  # Split on a comma with 0 or more spaces after it.
  # E.g. ENV['GASPAR_BLACKLIST'] = "foo.com, bar.com"
  # bad_origins = ["foo.com", "bar.com"]
  bad_origins = ENV['GASPAR_BLOCKED_URLS'].split(/,\s*/) 
  bad_origins_regexp = Regexp.union(bad_origins) 

  blocklist("block referer spam") do |request|
    request.referer =~ bad_origins_regexp 
  end

  # Block these user agents 
  bad_uas = ENV['GASPAR_BLOCKED_UA'].split(',')

  Rack::Attack.blocklist('block bad UA logins') do |req|
    bad_uas.include?(req.user_agent)
  end

  # Block these IPs
  bad_ips = ENV['GASPAR_BLOCKED_IPS'].split(',') 

  Rack::Attack.blocklist "Block IPs from GASPAR_BLOCKED_IPS" do |req|
    bad_ips.include?(req.ip)
  end

  # logging
  LOGGER = Logger.new("log/rack-attack.log")

  ActiveSupport::Notifications.subscribe('rack.attack') do |_name, _start, _finish, _request_id, payload|
    req = payload[:request] 
    if [:throttle, :blacklist, :blocklist].include? req.env['rack.attack.match_type']
      LOGGER.info ['rack-attack action:', req.env['rack.attack.match_type'], req.ip, req.request_method, req.fullpath, req.user_agent].join(' ')
    end
  end
end 