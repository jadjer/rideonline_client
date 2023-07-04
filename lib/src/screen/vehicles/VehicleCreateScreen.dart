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

class VehicleCreateScreen extends StatefulWidget {
  const VehicleCreateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VehicleCreateScreenState();
}

class _VehicleCreateScreenState extends State<VehicleCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create vehicle'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'qwe',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      debugPrint("Valid");
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
