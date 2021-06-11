module EventDecorator
  
  def join_count
    joins.count
  end

  def display_date
    if self.date.present?
      I18n.l(self.date, format: :default)
    end
  end

  def eyecatch_image
    if eyecatch.attached?
      eyecatch
    else
      'http://placehold.jp/eeeeee/cccccc/200x150.png?text=No%20Image'
    end
  end

end