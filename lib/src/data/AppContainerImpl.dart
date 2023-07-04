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

import 'package:http_interceptor/http_interceptor.dart';

import 'AppContainer.dart';
import 'repository/AuthRepository.dart';
import 'repository/EventRepository.dart';
import 'repository/impl/AuthRepositoryImpl.dart';
import 'repository/impl/EventRepositoryImpl.dart';
import '../utils/ExpiredTokenRetryPolicy.dart';
import '../utils/interceptor/AcceptInterceptor.dart';
import '../utils/interceptor/ApiKeyInterceptor.dart';
import '../utils/interceptor/AuthTokenInterceptor.dart';
import '../utils/interceptor/ContentTypeInterceptor.dart';
import '../utils/interceptor/ContentLanguageInterceptor.dart';

class AppContainerImpl implements AppContainer {
  late Client _client;

  AppContainerImpl() {
    _client = InterceptedClient.build(
      interceptors: [
        AcceptInterceptor(),
        ContentTypeInterceptor(),
        ApiKeyInterceptor(),
        AuthTokenInterceptor(),
        ContentLanguageInterceptor(),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(),
    );
  }

  @override
  AuthRepository get authRepository {
    return AuthRepositoryImpl(_client);
  }

  @override
  AnnouncementRepository get announcementRepository {
    return AnnouncementRepositoryImpl(_client);
  }
}
