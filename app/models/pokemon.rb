class Pokemon < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :order, presence: true, uniqueness: true
end
