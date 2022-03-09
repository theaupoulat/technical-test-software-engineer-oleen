# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: pretto/v1/user.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("pretto/v1/user.proto", :syntax => :proto3) do
    add_message "pretto.v1.FetchAllRequest" do
    end
    add_message "pretto.v1.FetchAllResponse" do
      repeated :users, :message, 1, "pretto.v1.User", json_name: "users"
    end
    add_message "pretto.v1.User" do
      optional :id, :uint64, 1, json_name: "id"
      optional :username, :string, 2, json_name: "username"
      optional :email, :string, 3, json_name: "email"
      optional :created_at, :message, 4, "google.protobuf.Timestamp", json_name: "createdAt"
    end
  end
end

module Pretto
  module V1
    FetchAllRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("pretto.v1.FetchAllRequest").msgclass
    FetchAllResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("pretto.v1.FetchAllResponse").msgclass
    User = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("pretto.v1.User").msgclass
  end
end