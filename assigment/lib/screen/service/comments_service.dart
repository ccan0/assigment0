import 'package:assigment/screen/model/comments_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentsService {
  Future<List<CommentsModel>> getComments() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);

    List<CommentsModel> comments = [];

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      for (var jsonResponseData in jsonResponse) {
        comments.add(CommentsModel.fromJson(jsonResponseData));
      }
      return comments;
    } else {
      throw Exception("Ürün yükleme işlemi başarısız oldu. Lütfen tekrar deneyiniz.");
    }
  }
}
