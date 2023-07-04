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
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../widget/PointOnMap.dart';

class EventsMapScreen extends StatefulWidget {
  const EventsMapScreen({super.key});

  @override
  State<EventsMapScreen> createState() => _EventsMapScreenState();
}

class _EventsMapScreenState extends State<EventsMapScreen> {
  late MapController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events on map'),
        ),
        body: const PointOnMap(latitude: 55.171356, longitude: 30.261677),
      ),
    );
  }
}
