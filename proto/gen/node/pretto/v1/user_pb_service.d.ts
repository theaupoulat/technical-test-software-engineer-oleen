// package: pretto.v1
// file: pretto/v1/user.proto

import * as pretto_v1_user_pb from "../../pretto/v1/user_pb";
import {grpc} from "@improbable-eng/grpc-web";

type UserServicefetchAll = {
  readonly methodName: string;
  readonly service: typeof UserService;
  readonly requestStream: false;
  readonly responseStream: false;
  readonly requestType: typeof pretto_v1_user_pb.FetchAllRequest;
  readonly responseType: typeof pretto_v1_user_pb.FetchAllResponse;
};

export class UserService {
  static readonly serviceName: string;
  static readonly fetchAll: UserServicefetchAll;
}

export type ServiceError = { message: string, code: number; metadata: grpc.Metadata }
export type Status = { details: string, code: number; metadata: grpc.Metadata }

interface UnaryResponse {
  cancel(): void;
}
interface ResponseStream<T> {
  cancel(): void;
  on(type: 'data', handler: (message: T) => void): ResponseStream<T>;
  on(type: 'end', handler: (status?: Status) => void): ResponseStream<T>;
  on(type: 'status', handler: (status: Status) => void): ResponseStream<T>;
}
interface RequestStream<T> {
  write(message: T): RequestStream<T>;
  end(): void;
  cancel(): void;
  on(type: 'end', handler: (status?: Status) => void): RequestStream<T>;
  on(type: 'status', handler: (status: Status) => void): RequestStream<T>;
}
interface BidirectionalStream<ReqT, ResT> {
  write(message: ReqT): BidirectionalStream<ReqT, ResT>;
  end(): void;
  cancel(): void;
  on(type: 'data', handler: (message: ResT) => void): BidirectionalStream<ReqT, ResT>;
  on(type: 'end', handler: (status?: Status) => void): BidirectionalStream<ReqT, ResT>;
  on(type: 'status', handler: (status: Status) => void): BidirectionalStream<ReqT, ResT>;
}

export class UserServiceClient {
  readonly serviceHost: string;

  constructor(serviceHost: string, options?: grpc.RpcOptions);
  fetchAll(
    requestMessage: pretto_v1_user_pb.FetchAllRequest,
    metadata: grpc.Metadata,
    callback: (error: ServiceError|null, responseMessage: pretto_v1_user_pb.FetchAllResponse|null) => void
  ): UnaryResponse;
  fetchAll(
    requestMessage: pretto_v1_user_pb.FetchAllRequest,
    callback: (error: ServiceError|null, responseMessage: pretto_v1_user_pb.FetchAllResponse|null) => void
  ): UnaryResponse;
}

