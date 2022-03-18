require 'pretto/v1/user_pb'
require 'pretto/v1/user_services_pb'

module Pretto
  module V1
    module UserService
      # Implementation of the user service RPCs spec
      class ServiceImpl < Service
        def fetch_all(_req, _call = nil)
          Pretto::V1::FetchAllResponse.new(
            users: ::User.all.as_json
          )
        end
      end
    end
  end
end
