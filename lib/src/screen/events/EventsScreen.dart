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
import '../../data/domain/Event.dart';
import '../../service/AnnouncementService.dart';
import '../../widget/EventCard.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final announcementService = context.read<AnnouncementService>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                context.goNamed(AppRouteName.eventsMap);
              },
            ),
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
          child: FutureBuilder<List<Event>>(
            future: announcementService.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error;
                return _errorPage(error.toString());
              }

              if (snapshot.hasData) {
                final eventsData = snapshot.data!;
                return _eventsListPage(eventsData);
              }

              return _loadingPage();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRouteName.eventCreate);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _errorPage(String errorMessage) {
    return Center(
      child: Text(errorMessage),
    );
  }

  Widget _loadingPage() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _eventsListPage(List<Event> events) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return EventCard(
          title: event.title,
          subtitle: event.subtitle,
          onTap: () {
            context.goNamed(
              AppRouteName.eventDetail,
              params: {'eventId': event.id.toString()},
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
