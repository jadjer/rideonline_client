/*
 * Copyright 2022 Pavel Suprunov
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class User {
  final int id;
  final String phone;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final int age;
  final String country;
  final String region;
  final String image;
  final bool isBlocked;

  User({
    required this.id,
    required this.phone,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.country,
    required this.region,
    required this.image,
    required this.isBlocked,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      phone: json['phone'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      country: json['country'] as String,
      region: json['region'] as String,
      image: json['image'] as String,
      isBlocked: json['is_blocked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'age': age,
      'country': country,
      'region': region,
      'image': image,
      'is_blocked': isBlocked,
    };
  }
}
