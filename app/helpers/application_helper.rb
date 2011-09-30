module ApplicationHelper
  def card_count_header(cards)
    "There #{cards.size == 1 ? 'is' : 'are'} #{pluralize cards.size, 'card'}"
  end
end
