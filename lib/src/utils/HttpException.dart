// Copyright 2023 Pavel Suprunov
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:developer';

class HttpException implements Exception {
  HttpException(this.message) {
    log(message);
  }

  final String message;
}

class ServerException extends HttpException {
  ServerException([String message = '']) : super('Server error: $message');
}

class NoInternetException extends HttpException {
  NoInternetException() : super('No Internet connection');
}

class ClientException extends HttpException {
  ClientException([String message = '']) : super('Client error: $message');
}

class UnknownException extends HttpException {
  UnknownException([String message = '']) : super('Unknown error: $message');
}

class NotFoundException extends HttpException {
  NotFoundException() : super('Not Found');
}

class TimeOverException extends HttpException {
  TimeOverException() : super('Time out of request');
}
