require 'grpc_web'
require 'rack/handler'
require 'services/user'

GRPCWeb.handle(Pretto::V1::UserService::ServiceImpl)
