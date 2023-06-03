class Animal < ApplicationRecord
    has_one_attached :image

    def image_as_thumbnail
        image.variant(resize_to_limit: [300, 300]).processed
    end
end
