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

import 'package:flutter/widgets.dart';

import '../data/domain/Phone.dart';
import '../data/domain/Username.dart';
import '../data/model/RegisterRequest.dart';
import '../data/repository/AuthRepository.dart';

class RegisterService extends ChangeNotifier {
  late String? _verificationToken;
  late AuthRepository _repository;
  late String? _phone;
  late String? _errorMessage;
  late bool _isRegistered;

  RegisterService(AuthRepository repository) {
    _verificationToken = null;
    _repository = repository;
    _phone = null;
    _errorMessage = null;
    _isRegistered = false;
  }

  bool get isRegistered => _isRegistered;

  String? get verificationToken => _verificationToken;

  String? get errorMessage => _errorMessage;

  Future<bool> existPhone(String phone) async {
    log('Check if phone $phone is exists');

    final phoneRequest = Phone(phone: phone);
    final result = await _repository.existPhone(phoneRequest);
    if (result.success) {
      return true;
    }

    return false;
  }

  Future<bool> existUsername(String username) async {
    log('Check if username $username is exists');

    final usernameRequest = Username(username: username);
    final result = await _repository.existUsername(usernameRequest);
    if (result.success) {
      return true;
    }

    return false;
  }

  Future<void> phoneVerify(String phone) async {
    log('Try send request with phone $phone');

    final phoneRequest = Phone(phone: phone);
    final result = await _repository.getVerificationCode(phoneRequest);
    if (result.success) {
      _phone = phone;
      _verificationToken = result.token!.verificationToken;
    } else {
      _errorMessage = result.message;
      log(_errorMessage!);
    }

    notifyListeners();
  }

  Future<void> signUp(String username, String password, String verificationCode) async {
    if (_phone == null) return;
    if (_verificationToken == null) return;

    final registerRequest = RegisterRequest(
      phone: _phone!,
      username: username,
      password: password,
      verificationCode: verificationCode,
      verificationToken: _verificationToken!,
    );

    final result = await _repository.register(registerRequest);
    if (result.success) {
      _isRegistered = true;
    } else {
      _errorMessage = result.message;
      log(_errorMessage!);
    }

    notifyListeners();
  }
}
