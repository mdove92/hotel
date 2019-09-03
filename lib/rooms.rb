module Hotel
  class Room
    attr_reader :id, :status

    def initialize(id:, status: AVAILABLE)
      @id = id
      @status = statuus

      accepted_statuses = [:UNAVAILABLE, :AVAILABLE]
      if !accepted_statuses.include?(status)
        raise ArgumentError.new("Invalid Status Input")
      end
    end
  end
end
