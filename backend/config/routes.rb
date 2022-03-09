Rails.application.routes.draw do
  mount GRPCWeb.rack_app => "/grpc"
end
