require 'test_helper'

class FanTest < ActiveSupport::TestCase
  should belong_to(:location)

  def valid_attributes
    {
      name: "Jorge",
      email: "yosoybelieber@example.com"
    }
  end

  def test_it_creates_a_fan
    result = Fan.new(valid_attributes)

    assert result.valid?
    assert_equal "Jorge", result.name
    assert_equal "yosoybelieber@example.com", result.email
  end

  def test_it_cannot_create_a_fan_with_a_name
    result = Fan.new(email: "yosoybelieber@example.com")

    assert result.invalid?
  end

  def test_it_cannot_create_a_fan_with_the_same_email
    2.times {Fan.create(valid_attributes)}

    result = Fan.where(email:  "yosoybelieber@example.com")
    assert_equal 1, result.count
  end

  def test_it_only_accepts_letters_as_a_name
    fan = Fan.new(
      name: "Jorge1",
      email: "yosoybelieber@example.com"
      )

      refute fan.valid?
  end

  def test_it_only_accepts_an_email_between_5_and_50_characters
    fan = Fan.new(
      name: "Jorge1",
      email: "Jorg"
      )

    assert fan.invalid?
  end

  def test_it_cannot_create_a_fan_named_dick
    fan = Fan.new(
      name: "Dick",
      email: "dick@dick.com"
      )

    assert fan.invalid?
    assert_includes fan.errors.full_messages, "Name cannot be Dick"
  end
end
