// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:thesocialapp/core/model/user_model.dart';

class Story {
  final int story_id;
  final List<String> story_assets;
  final DateTime story_date;
  final User story_user;

  Story({
    required this.story_id,
    required this.story_assets,
    required this.story_date,
    required this.story_user,
  });

  Story copyWith({
    int? story_id,
    List<String>? story_assets,
    DateTime? story_date,
    User? story_user,
  }) {
    return Story(
      story_id: story_id ?? this.story_id,
      story_assets: story_assets ?? this.story_assets,
      story_date: story_date ?? this.story_date,
      story_user: story_user ?? this.story_user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'story_id': story_id,
      'story_assets': story_assets,
      'story_date': story_date.millisecondsSinceEpoch,
      'story_user': story_user.toMap(),
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      story_id: map['story_id']?.toInt() ?? 0,
      story_assets: List<String>.from(map['story_assets']),
      story_date: DateTime.parse(map['story_date']),
      story_user: User.fromMap(map['story_user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Story(story_id: $story_id, story_assets: $story_assets, story_date: $story_date, story_user: $story_user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Story &&
        other.story_id == story_id &&
        listEquals(other.story_assets, story_assets) &&
        other.story_date == story_date &&
        other.story_user == story_user;
  }

  @override
  int get hashCode {
    return story_id.hashCode ^
        story_assets.hashCode ^
        story_date.hashCode ^
        story_user.hashCode;
  }
}
