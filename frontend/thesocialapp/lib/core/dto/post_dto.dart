import 'dart:convert';

class PostDTO {
  final String post_title;
  final String post_text;
  final String post_images;
  final String useremail;

  PostDTO({
    required this.post_title,
    required this.post_text,
    required this.post_images,
    required this.useremail,
  });

  Map<String, dynamic> toMap() {
    return {
      'post_title': post_title,
      'post_text': post_text,
      'post_images': post_images,
      'useremail': useremail,
    };
  }

  factory PostDTO.fromMap(Map<String, dynamic> map) {
    return PostDTO(
      post_title: map['post_title'] ?? '',
      post_text: map['post_text'] ?? '',
      post_images: map['post_images'] ?? '',
      useremail: map['useremail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDTO.fromJson(String source) =>
      PostDTO.fromMap(json.decode(source));
}
