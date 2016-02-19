class Fan < ActiveRecord::Base
  has_many :donations
  validates :name,  presence: true,
                    format: {with: /\A[a-zA-Z]+\z/, message: "only allows uppercase and lowercase letters"}

  validates :email, presence: true,
                    uniqueness: true,
                    length: {in: 5..50}

  validate :no_dicks

  belongs_to :location

  default_scope { order(:name) }

  def no_dicks
    errors.add(:name, "cannot be Dick") if name == "Dick"
  end

  def self.joined_since(date)
    # formatted_date = Time.new(date)
    # require "pry"; binding.pry
    all.where("created_at < ?", date)
  end

end
