require 'google/protobuf/timestamp_pb'

class DateTimeToGoogleProtobufTimestamp
   def self.call(datetime)
     Google::Protobuf::Timestamp.new({ seconds: datetime.to_datetime.to_i })
   end
end
