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

import '../../AppRouteName.dart';
import '../../data/domain/Vehicle.dart';
import '../../service/VehicleService.dart';
import '../../widget/VehicleDetails.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final int vehicleId;

  const VehicleDetailsScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    final vehicleService = context.read<VehicleService>();
    final futureVehicle = vehicleService.getVehicleById(vehicleId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                context.goNamed(
                  AppRouteName.vehicleEdit,
                  params: {'vehicleId': vehicleId.toString()},
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<Vehicle?>(
          future: futureVehicle,
          builder: (BuildContext context, AsyncSnapshot<Vehicle?> snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;

              return Center(
                child: Text(error.toString()),
              );
            }

            if (snapshot.hasData) {
              final vehicle = snapshot.data!;

              return VehicleDetails(vehicle: vehicle);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
