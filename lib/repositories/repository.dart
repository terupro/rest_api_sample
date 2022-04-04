import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_sample/models/post.dart';
import 'package:rest_api_sample/services/post_api_client.dart';

// APIを取得するためのメソッドをrepositoryから呼び出す
class Repository {
  final _api = PostApiClient();
  dynamic fetchPost() async {
    return await _api.fetchPost();
  }
}
