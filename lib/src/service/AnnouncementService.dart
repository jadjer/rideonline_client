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

import '../data/model/EventsResponse.dart';
import '../data/domain/Event.dart';
import '../data/repository/EventRepository.dart';

class AnnouncementService extends ChangeNotifier {
  List<Event> _events = [];

  final _eventsController = StreamController<Event>();

  late AnnouncementRepository _repository;

  AnnouncementService(AnnouncementRepository repository) {
    _repository = repository;
  }

  Stream<Event> getEventsStream() {
    return _eventsController.stream;
  }

  Future<List<Event>> getEvents() async {
    final eventsResponse = await _repository.getEvents();

    if (eventsResponse.success) {
      _events = eventsResponse.events;
    }

    return _events;
  }

  Future<Event?> getEventById(int eventId) async {
    Event? event;

    log('Try get event with $eventId from local');
    event = _events.firstWhereOrNull((event) => (event.id == eventId));

    if (event == null) {
      log('Try get event with $eventId from remove');

      final result = await _repository.getEvent(eventId);
      if (result.success) {
        event = result.event!;

        _events.add(event);

        log('Get data success');
      }

      log('Get data fail');
    }

    return event;
  }
}
