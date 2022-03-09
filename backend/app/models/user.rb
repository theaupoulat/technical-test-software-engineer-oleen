require 'helpers/datetime_to_google_protobuf_timestamp'

class User < ApplicationRecord
  def as_json
    super.as_json.slice(
      'id',
      'username',
      'email',
      'created_at'
    ).tap do |p|
      p['created_at'] = DateTimeToGoogleProtobufTimestamp.call(created_at)
    end
  end
end
