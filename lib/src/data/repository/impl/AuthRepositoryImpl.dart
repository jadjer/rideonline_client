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
import 'dart:convert';

import 'package:http/http.dart';

import '../AuthRepository.dart';
import '../../model/ChangePasswordRequest.dart';
import '../../model/UserResponse.dart';
import '../../model/UserUpdateRequest.dart';
import '../../domain/Phone.dart';
import '../../domain/Token.dart';
import '../../domain/Username.dart';
import '../../model/AuthResponse.dart';
import '../../model/ChangePhoneRequest.dart';
import '../../model/ExistResponse.dart';
import '../../model/LoginRequest.dart';
import '../../model/PhoneTokenResponse.dart';
import '../../model/RegisterRequest.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _baseUrl = 'auth.rideonline.jadjer.by';

  late Client _client;

  AuthRepositoryImpl(Client client) {
    _client = client;
  }

  @override
  Future<PhoneTokenResponse> getVerificationCode(Phone request) async {
    final url = Uri.https(_baseUrl, 'api/v2/get_verification_code');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return PhoneTokenResponse.fromJson(responseJson);
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    final url = Uri.https(_baseUrl, 'api/v2/register');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    final url = Uri.https(_baseUrl, 'api/v2/login');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<AuthResponse> changePassword(ChangePasswordRequest request) async {
    final url = Uri.https(_baseUrl, 'api/v2/change_password');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<AuthResponse> refreshToken(Token request) async {
    final url = Uri.https(_baseUrl, 'api/v2/refresh_token');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<UserResponse> getCurrentUser() async {
    final url = Uri.https(_baseUrl, 'api/v2/users');

    final response = await _client.get(url);
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return UserResponse.fromJson(responseJson);
  }

  @override
  Future<UserResponse> updateCurrentUser(UserUpdateRequest request) async {
    final url = Uri.https(_baseUrl, 'api/v2/users');

    final response = await _client.patch(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return UserResponse.fromJson(responseJson);
  }

  @override
  Future<UserResponse> changePhoneForCurrentUser(ChangePhoneRequest request) async {
    final url = Uri.https(_baseUrl, 'api/v2/users/change_phone');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return UserResponse.fromJson(responseJson);
  }

  @override
  Future<UserResponse> getUserByID(int userId) async {
    final url = Uri.https(_baseUrl, 'api/v2/users/$userId');

    final response = await _client.get(url);
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return UserResponse.fromJson(responseJson);
  }

  @override
  Future<ExistResponse> existUsername(Username request) async {
    final url = Uri.https(_baseUrl, 'api/v2/exists/username');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return ExistResponse.fromJson(responseJson);
  }

  @override
  Future<ExistResponse> existPhone(Phone request) async {
    final url = Uri.https(_baseUrl, 'api/v2/exists/phone');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return ExistResponse.fromJson(responseJson);
  }
}
