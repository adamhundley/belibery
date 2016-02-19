require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def valid_attributes
    {
      city: "Denver",
      state: "CO",
      country: "USA"
    }
  end

  def test_location_attributes
    result = Location.new(valid_attributes)

    assert result.valid?
    assert_equal "Denver", result.city
    assert_equal "CO", result.state
    assert_equal "USA", result.country
  end

  def test_location_missing_city
    result = Location.new(state: "CO", country: "USA")

    assert result.invalid?
  end

  def test_location_missing_state
    result = Location.new(city: "Denver", country: "USA")

    assert result.invalid?
  end

  def test_location_missing_country
    result = Location.new(city: "Denver", state: "CO")

    assert result.invalid?
  end

  def test_location_can_only_be_entered_once_per_state
    Location.create(city: "Bloomington", state: "IN", country: "USA")
    Location.create(city: "Bloomington", state: "IL", country: "USA")

    assert_equal 2, Location.count

    Location.create(city: "Bloomington", state: "IN", country: "USA")

    assert_equal 2, Location.count
  end

  def test_state_must_be_2_characters
    result = Location.new(city: "Denver", state: "COO", country: "USA")

    assert result.invalid?
  end

  def test_city_only_contain_letters_and_spaces
    result = Location.new(city: "SanDiego11", state: "CO", country: "USA" )

    assert result.invalid?
  end

  def test_country_only_contain_letters_and_spaces
    result = Location.new(city: "Denver", state: "CO", country: "US16" )

    assert result.invalid?
  end

  def test_full_name_returns_location
    location = Location.new(valid_attributes)

    result = "Denver, CO, USA"

    assert_equal result, location.full_name
  end
end
