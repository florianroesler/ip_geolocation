struct IPAddress
  IPV4_REGEX = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/

  property address : String

  def initialize(@address : String)
  end

  def to_i64
    if IPV4_REGEX.match(address)
      address.split(".").reduce(Int64.new(0)) { |total, value| (total << 8 ) + value.to_i }
    else
      address.to_i64?
    end
  end
end
