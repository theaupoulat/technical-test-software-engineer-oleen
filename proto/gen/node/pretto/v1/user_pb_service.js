// package: pretto.v1
// file: pretto/v1/user.proto

var pretto_v1_user_pb = require("../../pretto/v1/user_pb");
var grpc = require("@improbable-eng/grpc-web").grpc;

var UserService = (function () {
  function UserService() {}
  UserService.serviceName = "pretto.v1.UserService";
  return UserService;
}());

UserService.fetchAll = {
  methodName: "fetchAll",
  service: UserService,
  requestStream: false,
  responseStream: false,
  requestType: pretto_v1_user_pb.FetchAllRequest,
  responseType: pretto_v1_user_pb.FetchAllResponse
};

exports.UserService = UserService;

function UserServiceClient(serviceHost, options) {
  this.serviceHost = serviceHost;
  this.options = options || {};
}

UserServiceClient.prototype.fetchAll = function fetchAll(requestMessage, metadata, callback) {
  if (arguments.length === 2) {
    callback = arguments[1];
  }
  var client = grpc.unary(UserService.fetchAll, {
    request: requestMessage,
    host: this.serviceHost,
    metadata: metadata,
    transport: this.options.transport,
    debug: this.options.debug,
    onEnd: function (response) {
      if (callback) {
        if (response.status !== grpc.Code.OK) {
          var err = new Error(response.statusMessage);
          err.code = response.status;
          err.metadata = response.trailers;
          callback(err, null);
        } else {
          callback(null, response.message);
        }
      }
    }
  });
  return {
    cancel: function () {
      callback = null;
      client.close();
    }
  };
};

exports.UserServiceClient = UserServiceClient;

