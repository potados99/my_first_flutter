import 'dart:convert';

import 'package:http/http.dart' as http;

/**
 * example respons
 *
 * {
    "id": "f4666cca-10b1-4183-8700-84305b301c4b",
    "channel": "default",
    "commits": [
    {
    "type": "post",
    "body": "0x%5B%5D=androxgh0st",
    "author": {
    "name": null,
    "userAent": "Mozilla/5.0 (Linux; U; Android 4.4.2; en-US; HM NOTE 1W Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 UCBrowser/11.0.5.850 U3/0.8.0 Mobile Safari/534.30",
    "sourceIp": "94.156.6.167"
    },
    "committedAt": 1696411109279
    }
    ],
    "body": "0x%5B%5D=androxgh0st",
    "timestamp": 1696411109279,
    "date": "2023. 10. 4. 오후 6:18:29"
    },
 */

class Author {
  final String? name;
  final String? userAgent;
  final String sourceIp;

  Author({
    required this.name,
    required this.userAgent,
    required this.sourceIp,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] as String?,
      userAgent: json['userAgent'] as String?,
      sourceIp: json['sourceIp'] as String,
    );
  }
}

class Commit {
  final String type;
  final String body;
  final Author author;
  final int committedAt;

  Commit({
    required this.type,
    required this.body,
    required this.author,
    required this.committedAt,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      type: json['type'] as String,
      body: json['body'] as String,
      author: Author.fromJson(json['author']),
      committedAt: json['committedAt'] as int,
    );
  }
}

class Post {
  final String id;
  final String channel;
  final List<Commit> commits;
  final String body;
  final int timestamp;
  final String date;

  Post({
    required this.id,
    required this.channel,
    required this.commits,
    required this.body,
    required this.timestamp,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      channel: json['channel'] as String,
      commits: (json['commits'] as List).map((e) => Commit.fromJson(e)).toList(),
      body: json['body'] as String,
      timestamp: json['timestamp'] as int,
      date: json['date'] as String,
    );
  }

  static Future<List<Post>> fromChannel(String channel) async {
    final response = await http.get(
      Uri.https('collect.potados.com', '/$channel', {'response': 'api'}),
    );

    final json = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return json.map((e) => Post.fromJson(e)).toList();
  }
}
