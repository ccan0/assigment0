import 'package:assigment/core/constants/API/api_constans.dart';
import 'package:assigment/screen/model/comments_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentsService {
  Future<List<CommentsModel>> getComments() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);

    List<CommentsModel> comments = [];

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      for (var jsons2 in jsonResponse) {
        comments.add(CommentsModel.fromJson(jsons2));
      }
      return comments;
    } else {
      throw Exception("Ürün yükleme işlemi başarısız oldu. Lütfen tekrar deneyiniz.");
    }
  }
}
