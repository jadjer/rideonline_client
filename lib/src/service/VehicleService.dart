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
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../data/domain/Vehicle.dart';
import '../data/repository/EventRepository.dart';

class VehicleService extends ChangeNotifier {
  List<Vehicle> _vehicles = [];

  late AnnouncementRepository _repository;

  VehicleService(AnnouncementRepository repository) {
    _repository = repository;
  }

  Future<List<Vehicle>> getVehicles() async {
    // final eventsResponse = await _repository.getEvents();

    // if (eventsResponse.success) {
    //   _events = eventsResponse.events;
    // }

    return _vehicles;
  }

  Future<Vehicle?> getVehicleById(int vehicleId) async {
    Vehicle? vehicle;

    log('Try get vehicle with $vehicleId from local');
    vehicle = _vehicles.firstWhereOrNull((vehicle) => (vehicle.id == vehicleId));

    if (vehicle == null) {
      // log('Try get event with $eventId from remove');

      // final result = await _repository.getEvent(eventId);
      // if (result.success) {
      //   event = result.event!;

      //   _events.add(event);

      //   log('Get data success');
      // }

      log('Get data fail');
    }

    return vehicle;
  }
}
