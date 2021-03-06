require_relative 'fetcher'

class SlackApi < Fetcher
  def initialize(token)
    super('https://slack.com/api', token)
  end

  # https://api.slack.com/methods/auth.test
  def get_info
    json = get("/auth.test?token=#{token}")

    return unless json && json['ok']

    json
  end

  # https://api.slack.com/methods/users.profile.set
  def set_status(status)
    profile = {
      'status_text' => status,
      'status_emoji' => ':musical_note:'
    }
    data = { 'token' => token, 'profile' => profile.to_json }
    json = post('/users.profile.set') do |req|
      req.set_form_data(data)
    end

    json && json['ok']
  end
end
