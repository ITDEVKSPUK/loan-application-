class PostModel {
  final String name;

  PostModel({required this.name});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(name: json['village']);
  }
}
