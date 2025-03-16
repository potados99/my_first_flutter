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
      title: 'My First Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade300),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Feed'),
    );
  }
}

@riverpod
Future<List<Post>> posts(Ref ref, String channel) async {
  return Post.fromChannel(channel);
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const channel = 'goddamnlog';
    final posts = ref.watch(postsProvider(channel));

    Future<void> refresh() async {
      if (await Haptics.canVibrate()) {
        Haptics.vibrate(HapticsType.light);
      }
      try {
        await ref.refresh(postsProvider(channel).future);

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
            child: Scrollbar(
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
        onPressed: () => {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
