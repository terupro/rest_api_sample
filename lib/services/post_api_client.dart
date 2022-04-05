import 'package:rest_api_sample/models/post.dart';
import 'package:dio/dio.dart';

// APIを呼び出し、データを取得する
class PostApiClient {
  Future<List<Post>?> fetchPost() async {
    final dio = Dio();
    const url = "https://jsonplaceholder.typicode.com/posts";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      try {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Post.fromJson(e)).toList();
        return list;
      } catch (e) {
        print(e);
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Post.fromJson(e)).toList();
        return list;
        ;
      }
    }
  }
}
