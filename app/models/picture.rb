class Picture < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant( :thumb , resize_to_limit: [80, 80])
  end
end
