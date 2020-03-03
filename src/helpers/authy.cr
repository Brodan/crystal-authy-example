require "http/client"

def create_authy_user(email, phone, country_code)
  HTTP::Client.new("api.authy.com", 443, true) do |client|
    response = client.post("/protected/json/users/new", form: {
      "user[email]"        => email,
      "user[cellphone]"    => phone,
      "user[country_code]" => country_code,
    }, headers: HTTP::Headers{"X-Authy-API-Key" => "#{Amber.settings.secrets["AUTHY_API_KEY"]}"})
    result = JSON.parse(response.body)
    if response.success? && result["success"]
      result["user"]["id"].to_s
    end
  end
end

def send_OTP(authy_id)
  HTTP::Client.new("api.authy.com", 443, true) do |client|
    response = client.get("/protected/json/sms/#{authy_id}",
      headers: HTTP::Headers{"X-Authy-API-Key" => "#{Amber.settings.secrets["AUTHY_API_KEY"]}"})
    result = JSON.parse(response.body)
    response.success? && result["success"]
  end
end

def verify_authy_token(authy_id, token)
  HTTP::Client.new("api.authy.com", 443, true) do |client|
    response = client.get("/protected/json/verify/#{token}/#{authy_id}",
      headers: HTTP::Headers{"X-Authy-API-Key" => "#{Amber.settings.secrets["AUTHY_API_KEY"]}"})
    result = JSON.parse(response.body)
    response.success? && result["success"]
  end
end
