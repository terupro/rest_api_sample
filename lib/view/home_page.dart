import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_sample/models/post.dart';
import 'package:rest_api_sample/repositories/repository.dart';
import 'package:rest_api_sample/services/post_api_client.dart';

// Repositoryを保持したrepositoryProviderインスタンスを生成
final repositoryProvider = Provider((ref) => Repository());

final listProvider = FutureProvider<List<Post>>((ref) async {
  // Repositoryインスタンスを取得
  final repository = ref.read(repositoryProvider);
  // repository.fetchListメソッドの実行結果を返す
  return await repository.fetchPost();
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listProviderの監視
    final asyncValue = ref.watch(listProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Rest Api Sample')),
      body: Center(
        child: asyncValue.when(
          // dataに取得したいデータが格納されている
          data: (data) {
            return data.isNotEmpty
                ? ListView(
                    children: data
                        .map(
                          (Post post) => Card(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(post.id.toString()),
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(post.body!),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                leading: Text(post.id.toString()),
                                title: Text(post.title!),
                                trailing: const Icon(Icons.more_vert),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : const Text('Data is empty.');
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
