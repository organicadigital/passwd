class DomainEmailValidator < ActiveModel::EachValidator
  ALLOWED_DOMAIN = Rails.application.secrets.allowed_user_domain
  MATCH = /@#{ALLOWED_DOMAIN}\z/

  def validate_each(record, attribute, value)
    return if value.blank? || value.match(MATCH)

    record.errors.add(attribute, error_message)
  end

  private

  def error_message
    I18n.t('errors.messages.invalid_domain', domain: ALLOWED_DOMAIN)
  end
end