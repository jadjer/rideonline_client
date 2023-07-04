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
import '../../widget/VehicleCard.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final vehicleService = context.read<VehicleService>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehicles'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: FutureBuilder<List<Vehicle>>(
            future: vehicleService.getVehicles(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error;

                return Center(
                  child: Text(error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final vehiclesData = snapshot.data!;

              if (vehiclesData.isEmpty) {
                return const Center(
                  child: Text('No vehicles'),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: vehiclesData.length,
                itemBuilder: (context, index) {
                  final vehicle = vehiclesData[index];

                  return VehicleCard(
                    name: vehicle.title,
                    onTap: () {
                      context.goNamed(
                        AppRouteName.vehicleDetail,
                        params: {'vehicleId': vehicle.id.toString()},
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRouteName.vehicleCreate);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
