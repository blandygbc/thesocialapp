// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:thesocialapp/core/model/user_model.dart';

class Post {
  List<PostData> data;
  bool received;

  Post({
    required this.data,
    required this.received,
  });

  Post copyWith({
    List<PostData>? data,
    bool? received,
  }) {
    return Post(
      data: data ?? this.data,
      received: received ?? this.received,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'received': received,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      data: List<PostData>.from(map['data']?.map((x) => PostData.fromMap(x))),
      received: map['received'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() => 'Post(data: $data, received: $received)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Post &&
        listEquals(other.data, data) &&
        other.received == received;
  }

  @override
  int get hashCode => data.hashCode ^ received.hashCode;
}

class PostData {
  int post_id;
  String post_title;
  String post_text;
  List<String> post_images;
  DateTime post_time;
  dynamic post_comments;
  int post_likes;
  User post_user;

  PostData({
    required this.post_id,
    required this.post_title,
    required this.post_text,
    required this.post_images,
    required this.post_time,
    required this.post_comments,
    required this.post_likes,
    required this.post_user,
  });

  PostData copyWith({
    int? post_id,
    String? post_title,
    String? post_text,
    List<String>? post_images,
    DateTime? post_time,
    dynamic post_comments,
    int? post_likes,
    User? post_user,
  }) {
    return PostData(
      post_id: post_id ?? this.post_id,
      post_title: post_title ?? this.post_title,
      post_text: post_text ?? this.post_text,
      post_images: post_images ?? this.post_images,
      post_time: post_time ?? this.post_time,
      post_comments: post_comments ?? this.post_comments,
      post_likes: post_likes ?? this.post_likes,
      post_user: post_user ?? this.post_user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': post_id,
      'post_title': post_title,
      'post_text': post_text,
      'post_images': post_images,
      'post_time': post_time.millisecondsSinceEpoch,
      'post_comments': post_comments,
      'post_likes': post_likes,
      'post_user': post_user.toMap(),
    };
  }

  factory PostData.fromMap(Map<String, dynamic> map) {
    return PostData(
      post_id: map['post_id']?.toInt() ?? 0,
      post_title: map['post_title'] ?? '',
      post_text: map['post_text'] ?? '',
      post_images: List<String>.from(map['post_images']),
      post_time: DateTime.parse(map['post_time']),
      post_comments: map['post_comments'] ?? '',
      post_likes: map['post_likes']?.toInt() ?? 0,
      post_user: User.fromMap(map['post_user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostData.fromJson(String source) =>
      PostData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostData(post_id: $post_id, post_title: $post_title, post_text: $post_text, post_images: $post_images, post_time: $post_time, post_comments: $post_comments, post_likes: $post_likes, post_user: $post_user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PostData &&
        other.post_id == post_id &&
        other.post_title == post_title &&
        other.post_text == post_text &&
        listEquals(other.post_images, post_images) &&
        other.post_time == post_time &&
        other.post_comments == post_comments &&
        other.post_likes == post_likes &&
        other.post_user == post_user;
  }

  @override
  int get hashCode {
    return post_id.hashCode ^
        post_title.hashCode ^
        post_text.hashCode ^
        post_images.hashCode ^
        post_time.hashCode ^
        post_comments.hashCode ^
        post_likes.hashCode ^
        post_user.hashCode;
  }
}
