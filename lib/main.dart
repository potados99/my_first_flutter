import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_flutter/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@riverpod
Future<List<Post>> posts(Ref ref) async {
  return Post.fromChannel('goddamnlog');
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(postsProvider.future),
        child: ListView(
          children: posts.valueOrNull?.map((post) => ListTile(
            title: Text(post.body),
            subtitle: Text(post.date),
          )).toList() ?? const [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(postsProvider.future),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
