class Lookup
  @hash = Hash(Range(Int32, Int32), Location).new

  def push(min : Int32, max : Int32, location : Location)
    @hash[min..max] = location
  end

  def find(value : Int32)
    result = @hash.find do |range, location|
      range.includes?(value)
    end

    if result
      result.last
    end
  end
end
