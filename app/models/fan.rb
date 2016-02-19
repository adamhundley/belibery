class Fan < ActiveRecord::Base
  validates :name,  presence: true,
                    format: {with: /\A[a-zA-Z]+\z/, message: "only allows uppercase and lowercase letters"}

  validates :email, presence: true,
                    uniqueness: true,
                    length: {in: 5..50}

  validate :no_dicks

  belongs_to :location 

  def no_dicks
    errors.add(:name, "cannot be Dick") if name == "Dick"
  end

  has_many :donations
end
