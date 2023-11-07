class Pokemon < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :order, presence: true, uniqueness: true

    has_many :pokemon_types, dependent: :destroy
    has_many :types, through: :pokemon_types

    accepts_nested_attributes_for :pokemon_types, allow_destroy: true
end
