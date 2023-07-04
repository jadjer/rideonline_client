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
import '../../../service/AuthService.dart';
import '../../../widget/AuthScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    if (auth.isAuthenticated) {
      Future.microtask(() {
        context.goNamed(AppRouteName.events);
      });
    }

    return AuthScaffold(
      title: 'Login',
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
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    autofocus: true,
                    controller: _usernameTextController,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTextController,
                  ),
                )
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
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () async {
              final username = _usernameTextController.text;
              final password = _passwordTextController.text;

              await auth.signIn(username, password);
            },
          ),
          const SizedBox(height: 70),
          InkWell(
            child: const Text(
              'Change password',
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
              ),
            ),
            onTap: () {
              context.goNamed(AppRouteName.changePasswordPhone);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }
}
