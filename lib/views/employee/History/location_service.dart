  import 'dart:convert';
  import 'package:http/http.dart' as http;

  import 'package:loan_apllication/views/employee/History/models_history_location.dart';

  class ApiService {
    final String baseUrl =
        'https://www.emsifa.com/api-wilayah-indonesia/api/regencies/33.json';

    Future<List<PostModel>> fetchPosts() async {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    }
  }