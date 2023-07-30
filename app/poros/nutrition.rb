class Nutrition
  attr_reader :total_weight_in_grams

  def initialize(details)
    @total_weight_in_grams = sum_weight(details)
  end

  def sum_weight(details)
    weight = details.sum { |item| item[:serving_size_g] }
  end
end
