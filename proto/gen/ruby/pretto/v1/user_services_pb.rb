# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: pretto/v1/user.proto for package 'pretto.v1'

require 'grpc'
require 'pretto/v1/user_pb'

module Pretto
  module V1
    module UserService
      class Service

        include ::GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'pretto.v1.UserService'

        rpc :fetchAll, ::Pretto::V1::FetchAllRequest, ::Pretto::V1::FetchAllResponse
      end

      Stub = Service.rpc_stub_class
    end
  end
end
