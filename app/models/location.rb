class Location < ActiveRecord::Base
  validates :city,  presence: true,
                    uniqueness: { scope: :state, message: "only one city name per state"},
                    format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }

  validates :state, presence: true,
                    length: { maximum: 2 }

  validates :country, presence: true,
                      format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  def full_name
    "#{city}, #{state}, #{country}"
  end

end
