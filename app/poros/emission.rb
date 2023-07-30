class Emission
  attr_reader :co2_kg

  def initialize(details)
    @co2_kg = details[:co2e]
  end
end
