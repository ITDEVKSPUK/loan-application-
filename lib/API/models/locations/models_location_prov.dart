class PostModel {
  final String province;

  PostModel({required this.province});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(province : json['province']);
  }
}
