class Range
  def overlaps?(other)
    include?(other.first) || other.include?(first)
  end
end