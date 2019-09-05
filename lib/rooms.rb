# module Hotel
#   class Room
#     attr_reader :id
#     attr_accessor :status

#     def initialize(id:, status: :AVAILABLE)
#       @id = id
#       @status = status

#       accepted_statuses = [:UNAVAILABLE, :AVAILABLE]
#       if !accepted_statuses.include?(status)
#         raise ArgumentError.new("Invalid Status Input")
#       end
#     end
#   end
# end
