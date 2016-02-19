require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  should belong_to(:fan)

  def valid_attributes
    {
      amount: 150,
      status: "pending",
    }
  end

  def test_valid_attributes
    result = Donation.new(valid_attributes)

    assert result.valid?
  end

  def test_a_donation_must_be_a_whole_number
    result = Donation.new(amount: 124.33)

    assert result.invalid?
  end

  def test_a_donation_must_have_a_status_of_pending_processed_cancelled
    result = Donation.new(amount: 124, status: "booger")

    assert result.invalid?
  end

  def test_donation_is_more_than_1_dollar
    result = Donation.new(amount: 1, status: "pending")

    assert result.invalid?
  end

end
