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
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../AppRouteName.dart';
import '../../data/domain/Event.dart';
import '../../service/AnnouncementService.dart';
import '../../widget/PointOnMap.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  @override
  State<StatefulWidget> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    final events = context.read<AnnouncementService>();
    final futureEvent = events.getEventById(widget.eventId);

    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return SafeArea(
      child: FutureBuilder<Event?>(
        future: futureEvent,
        builder: (BuildContext context, AsyncSnapshot<Event?> snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return _errorPage(error.toString());
          }

          if (snapshot.hasData) {
            final event = snapshot.data!;
            return _detailsPage(event);
          }

          return _loadingPage();
        },
      ),
    );
  }

  Widget _errorPage(String errorMessage) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }

  Widget _loadingPage() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _detailsPage(Event event) {
    return Scaffold(
      appBar: AppBar(
        actions: _actions(),
      ),
      body: Material(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              panelBuilder: (sc) => _panel(sc, event),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
              }),
            ),
            Positioned(
              right: 20.0,
              bottom: _fabHeight,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.gps_fixed,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _actions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.edit,
          // color: Colors.white,
        ),
        onPressed: () {
          context.goNamed(
            AppRouteName.eventEdit,
            params: {'eventId': widget.eventId.toString()},
          );
        },
      ),
    ];
  }

  Widget _body() {
    return const PointOnMap(
      latitude: 55.171356,
      longitude: 30.261677,
    );
  }

  Widget _panel(ScrollController sc, Event event) {
    return ListView(
      controller: sc,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24.0),
          child: _panelRow(
            'Images',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                  fit: BoxFit.cover,
                ),
                CachedNetworkImage(
                  imageUrl: "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                  width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24.0),
          child: _panelRow(
            'About',
            Text(
              event.text,
              softWrap: true,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24.0),
        )
      ],
    );
  }

  Widget _panelRow(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 12.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          child,
        ],
      ),
    );
  }
}
