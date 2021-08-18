module ProfileDecorator
  def age_cal
    return I18n.t('profiles.not-set') if age.blank?

    years = Time.zone.now.year - age.year
    days = Time.zone.now.yday - age.yday
    if days.negative?
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
