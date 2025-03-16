// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsHash() => r'bcd2a4ef43797aedb17cceda99bc3a794e397b0d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [posts].
@ProviderFor(posts)
const postsProvider = PostsFamily();

/// See also [posts].
class PostsFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [posts].
  const PostsFamily();

  /// See also [posts].
  PostsProvider call(
    String channel,
  ) {
    return PostsProvider(
      channel,
    );
  }

  @override
  PostsProvider getProviderOverride(
    covariant PostsProvider provider,
  ) {
    return call(
      provider.channel,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postsProvider';
}

/// See also [posts].
class PostsProvider extends AutoDisposeFutureProvider<List<Post>> {
  /// See also [posts].
  PostsProvider(
    String channel,
  ) : this._internal(
          (ref) => posts(
            ref as PostsRef,
            channel,
          ),
          from: postsProvider,
          name: r'postsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsHash,
          dependencies: PostsFamily._dependencies,
          allTransitiveDependencies: PostsFamily._allTransitiveDependencies,
          channel: channel,
        );

  PostsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channel,
  }) : super.internal();

  final String channel;

  @override
  Override overrideWith(
    FutureOr<List<Post>> Function(PostsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostsProvider._internal(
        (ref) => create(ref as PostsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channel: channel,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Post>> createElement() {
    return _PostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostsRef on AutoDisposeFutureProviderRef<List<Post>> {
  /// The parameter `channel` of this provider.
  String get channel;
}

class _PostsProviderElement extends AutoDisposeFutureProviderElement<List<Post>>
    with PostsRef {
  _PostsProviderElement(super.provider);

  @override
  String get channel => (origin as PostsProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
