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

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../AppRouteName.dart';

enum ScaffoldTab { events, vehicles, profile, settings }

class NavigationScaffold extends StatelessWidget {
  final Widget child;
  final ScaffoldTab selectedTab;

  const NavigationScaffold({
    super.key,
    required this.selectedTab,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdaptiveNavigationScaffold(
        selectedIndex: selectedTab.index,
        body: child,
        onDestinationSelected: (index) {
          switch (ScaffoldTab.values[index]) {
            case ScaffoldTab.events:
              context.goNamed(AppRouteName.events);
              break;
            case ScaffoldTab.vehicles:
              context.goNamed(AppRouteName.vehicles);
              break;
            case ScaffoldTab.profile:
              context.goNamed(AppRouteName.userDetail);
              break;
            case ScaffoldTab.settings:
              context.goNamed(AppRouteName.settings);
              break;
          }
        },
        destinations: const <AdaptiveScaffoldDestination>[
          AdaptiveScaffoldDestination(
            title: 'Events',
            icon: Icons.event,
          ),
          AdaptiveScaffoldDestination(
            title: 'My vehicles',
            icon: Icons.two_wheeler,
          ),
          AdaptiveScaffoldDestination(
            title: 'Profile',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
