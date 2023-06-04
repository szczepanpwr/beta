class Animal < ApplicationRecord
    has_one_attached :image
    has_many :adoptions, dependent: :destroy
    validates :image, presence: true
    def image_as_thumbnail
        image.variant(resize_to_limit: [300, 300]).processed
    end
end
