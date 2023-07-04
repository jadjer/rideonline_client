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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../AppRouteName.dart';
import '../../../service/RegisterService.dart';
import '../../../widget/AuthScaffold.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterService>();

    if (register.isRegistered) {
      Future.microtask(() {
        context.goNamed(AppRouteName.login);
      });
    }

    if (register.verificationToken != null) {
      Future.microtask(() {
        context.goNamed(AppRouteName.register);
      });
    }

    return AuthScaffold(
      title: 'Phone number',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(143, 148, 251, 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, .2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '+375123456789',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      errorText: register.errorMessage,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    controller: _phoneTextController,
                    onChanged: (String value) async {
                      await register.existPhone(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
              child: const Center(
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () async {
              // final auth = Provider.of<AuthService>(context, listen: false);
              await register.phoneVerify(_phoneTextController.text);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneTextController.dispose();

    super.dispose();
  }
}
