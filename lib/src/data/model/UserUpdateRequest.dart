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

class UserUpdateRequest {
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final int age;
  final String country;
  final String region;
  final String image;

  UserUpdateRequest({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.country,
    required this.region,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'age': age,
      'country': country,
      'region': region,
      'image': image,
    };
  }
}
