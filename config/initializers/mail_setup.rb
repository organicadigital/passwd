Rails.application.config.action_mailer.tap do |action_mailer|
  secrets = Rails.application.secrets

  action_mailer.default_url_options = secrets.default_url_options
  action_mailer.smtp_settings = secrets.smtp_settings
end