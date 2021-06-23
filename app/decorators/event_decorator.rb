module EventDecorator
  
  def join_count
    joins.count
  end

  def display_date
    if self.start_time.present?
      I18n.l(self.start_time, format: :default)
    else
      I18n.t('events.show.undecided')
    end
  end

  def display_store
    if self.store.present?
      self.store
    else
      I18n.t('events.show.undecided')
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