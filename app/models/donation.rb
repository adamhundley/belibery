class Donation < ActiveRecord::Base
  belongs_to :fan

  validates :amount,  presence: true,
                      numericality: { only_integer: true,         greater_than: 1 }
  validates :status,  presence: true,
                      inclusion: { in: %w(pending cancelled processed), message: "Status can't be %{value} "}

end
