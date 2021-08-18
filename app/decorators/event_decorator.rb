module EventDecorator
  def join_count
    joins.count
  end

  def display_date
    if start_time.present?
      I18n.l(start_time, format: :default)
    else
      I18n.t('events.show.undecided')
    end
  end

  def display_store
    store.presence || I18n.t('events.show.undecided')
  end

  def category_name
    if category.present?
      category.name
    else
      I18n.t('events.show.unspecified')
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
