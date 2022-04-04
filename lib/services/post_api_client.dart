import 'package:rest_api_sample/models/post.dart';
import 'package:dio/dio.dart';

// APIを呼び出し、データを取得する
class PostApiClient {
  dynamic fetchPost() async {
    final dio = Dio();
    const url = "https://jsonplaceholder.typicode.com/posts";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        var post = response.data
            .map((dynamic i) => Post.fromJson(i as Map<String, dynamic>))
            .toList();
        print(post);
        return post;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
