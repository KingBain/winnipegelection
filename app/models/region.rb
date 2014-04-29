class Region < ActiveRecord::Base
  belongs_to :region_type, inverse_of: :regions

  has_many :electoral_races, inverse_of: :region
  has_many :elections, through: :electoral_races

  # Self-Join For Sub-Regions / Parent Region
  has_many :sub_regions,
           class_name: 'Region',
           foreign_key: 'region_id',
           inverse_of: :parent_region
  belongs_to :parent_region,
             class_name: 'Region',
             foreign_key: 'region_id',
             inverse_of: :sub_regions

  validates :name, :region_type, presence: true
end