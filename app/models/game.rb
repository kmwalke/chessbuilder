class Game < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :guest, class_name: 'User'

  def name
    "#{host.name} VS #{guest.name} - #{created_at.to_fs(:long_ordinal)}"
  end
end
