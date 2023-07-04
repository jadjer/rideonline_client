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
import 'dart:convert';

import 'package:http/http.dart';

import '../EventRepository.dart';
import '../../model/EventResponse.dart';
import '../../model/EventsResponse.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final _baseUrl = 'events.rideonline.jadjer.by';

  late Client _client;

  AnnouncementRepositoryImpl(Client client) {
    _client = client;
  }

  // @override
  // Future<EventResponse> createEvent(Event request) async {
  //   final data = jsonEncode(request.toJson());
  //
  //   _channel.sink.add(data);
  //
  //   return EventResponse.fromJson(responseJson);
  // }

  @override
  Future<EventsResponse> getEvents() async {
    final url = Uri.https(_baseUrl, 'api/v1/events');

    final response = await _client.get(url);
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return EventsResponse.fromJson(responseJson);
  }

  @override
  Future<EventResponse> getEvent(int eventId) async {
    final url = Uri.https(_baseUrl, 'api/v1/events/$eventId');

    final response = await _client.get(url);
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    return EventResponse.fromJson(responseJson);
  }

  // @override
  // Future<EventResponse> updateEvent(int eventId, Event request) async {
  //   final url = Uri.https(_baseUrl, 'events/$eventId');
  //
  //   final response = await _client.patch(url, body: jsonEncode(request.toJson()));
  //   final responseJson = jsonDecode(response.body);
  //
  //   return EventResponse.fromJson(responseJson);
  // }

  // @override
  // Future<EventResponse> deleteEvent(int eventId) async {
  //   final url = Uri.https(_baseUrl, 'events/$eventId');
  //
  //   final response = await _client.delete(url);
  //   final responseJson = jsonDecode(response.body);
  //
  //   return EventResponse.fromJson(responseJson);
  // }
}
