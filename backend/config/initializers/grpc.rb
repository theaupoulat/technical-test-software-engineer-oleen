require 'grpc_web'
require 'services/user'

GRPCWeb.handle(Pretto::V1::UserService::ServiceImpl)
