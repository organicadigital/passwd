Rails.application.config.action_mailer.tap do |action_mailer|
  configs = Rails.application.secrets.action_mailer.with_indifferent_access

  action_mailer.default_url_options = configs[:default_url_options]
  action_mailer.smtp_settings = configs[:smtp_settings]
end