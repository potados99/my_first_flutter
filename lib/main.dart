import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
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

    Future<void> refresh() async {
      if (await Haptics.canVibrate()) {
        Haptics.vibrate(HapticsType.light);
      }
      try {
        await ref.refresh(postsProvider.future);

        if (await Haptics.canVibrate()) {
          Haptics.vibrate(HapticsType.success);
        }
      } catch (e) {
        if (await Haptics.canVibrate()) {
          Haptics.vibrate(HapticsType.error);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: refresh,
            child: ListView(
              children: switch (posts) {
                AsyncData(:final value) when value.isNotEmpty => value
                    .map(
                      (post) => ListTile(
                        title: Text(post.body),
                        subtitle: Text(post.date),
                      ),
                    )
                    .toList(),
                _ => [],
              },
            ),
          ),
          if (posts is AsyncLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (posts is AsyncError)
            const Center(
              child: Text(
                'Error loading posts',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          if (posts case AsyncData(:final value) when value.isEmpty)
            const Center(
              child: Text(
                'No posts available',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(postsProvider.future),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
