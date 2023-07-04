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

import '../data/domain/Vehicle.dart';

class VehicleDetails extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetails({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                vehicle.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                vehicle.subtitle,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(vehicle.text),
            ),
          ],
        ),
      ),
    );
  }
}
