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

import 'dart:async';

import '../domain/Phone.dart';
import '../domain/Token.dart';
import '../domain/Username.dart';
import '../model/AuthResponse.dart';
import '../model/ChangePasswordRequest.dart';
import '../model/ChangePhoneRequest.dart';
import '../model/ExistResponse.dart';
import '../model/LoginRequest.dart';
import '../model/PhoneTokenResponse.dart';
import '../model/RegisterRequest.dart';
import '../model/UserResponse.dart';
import '../model/UserUpdateRequest.dart';

abstract class AuthRepository {
  Future<PhoneTokenResponse> getVerificationCode(Phone request);

  Future<AuthResponse> register(RegisterRequest request);

  Future<AuthResponse> login(LoginRequest request);

  Future<AuthResponse> changePassword(ChangePasswordRequest request);

  Future<AuthResponse> refreshToken(Token request);

  Future<UserResponse> getCurrentUser();

  Future<UserResponse> updateCurrentUser(UserUpdateRequest request);

  Future<UserResponse> changePhoneForCurrentUser(ChangePhoneRequest request);

  Future<UserResponse> getUserByID(int userId);

  Future<ExistResponse> existUsername(Username request);

  Future<ExistResponse> existPhone(Phone request);
}
