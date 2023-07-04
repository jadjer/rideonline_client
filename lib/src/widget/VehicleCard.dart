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

class VehicleCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      color: Colors.white10,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: const Icon(
            Icons.bike_scooter,
            size: 60,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Text(
            '596m',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          contentPadding: const EdgeInsets.all(25.0),
        ),
      ),
    );
  }
}
