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

class PointOnMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const PointOnMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude, longitude),
        zoom: 18.0,
        maxZoom: 18.0,
        minZoom: 12.0,
        rotation: 0.0,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      nonRotatedChildren: <Widget>[
        MarkerLayer(
          markers: <Marker>[
            Marker(
              point: LatLng(latitude, longitude),
              height: 60,
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 48.0,
              ),
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}@2x.png?key=4Qeq0aHMQpH9LdJhF1N9',
          userAgentPackageName: 'by.jadjer.rideonline.announcement',
        ),
      ],
    );
  }
}
