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

class Vehicle {
  final int id;
  final String title;
  final String subtitle;
  final String text;
  final String picture;

  Vehicle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.text,
    required this.picture,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      text: json['text'] as String,
      picture: json['picture'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'text': text,
      'picture': picture,
    };
  }
}
