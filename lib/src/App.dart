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
import 'package:provider/provider.dart';

import 'AppRouter.dart';
import 'data/AppContainer.dart';
import 'service/VehicleService.dart';
import 'service/ChangePasswordService.dart';
import 'service/AuthService.dart';
import 'service/AnnouncementService.dart';
import 'service/RegisterService.dart';
import 'theme/AppThemeDark.dart';
import 'theme/AppThemeLight.dart';

class App extends StatelessWidget {
  late final AppRouter _appRouter;
  late final AuthService _authService;
  late final AppContainer _appContainer;
  late final VehicleService _vehicleService;
  late final RegisterService _registerService;
  late final AnnouncementService _announcementService;
  late final ChangePasswordService _changePasswordService;

  App(AppContainer appContainer, {super.key}) {
    _appContainer = appContainer;

    _authService = AuthService(_appContainer.authRepository);
    _vehicleService = VehicleService(_appContainer.announcementRepository);
    _registerService = RegisterService(_appContainer.authRepository);
    _announcementService = AnnouncementService(_appContainer.announcementRepository);
    _changePasswordService = ChangePasswordService(_appContainer.authRepository);

    _appRouter = AppRouter(auth: _authService);

    _authService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: _authService),
        ChangeNotifierProvider<RegisterService>.value(value: _registerService),
        ChangeNotifierProvider<ChangePasswordService>.value(value: _changePasswordService),
        ChangeNotifierProvider<AnnouncementService>.value(value: _announcementService),
        ChangeNotifierProvider<VehicleService>.value(value: _vehicleService),
        Provider<AppRouter>.value(value: _appRouter),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final appRoute = context.watch<AppRouter>();

          return MaterialApp.router(
            routerConfig: appRoute.router,
            title: 'Ride Online',
            debugShowCheckedModeBanner: false,
            theme: AppThemeLight().toThemeData(),
            darkTheme: AppThemeDark().toThemeData(),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
