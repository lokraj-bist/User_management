import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localnetwork/models/user.dart';

class ApiService {
  static final _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Post>> fetchPosts(int userId) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/users/$userId/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Comment>> fetchComments(int postId) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/posts/$postId/comments'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
