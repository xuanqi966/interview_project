import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import '../models/post.dart';
import 'package:http/http.dart' as http;

class Posts with ChangeNotifier {
  final _rootAddress = 'https://jsonplaceholder.typicode.com/posts';

  List<Post> _posts = [];
  int _currUserId = -1;
  int _currMaxId = -1;

  // logic to generate dummy userId
  Random random = Random();

  bool _isError = false;

  Future<void> loadPosts() async {
    try {
      _currUserId = random.nextInt(100);

      final response = await http.get(Uri.parse(_rootAddress));

      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        jsondata.forEach((post) {
          int userId = post['userId'];
          int id = post['id'];
          String title = post['title'];
          String body = post['body'];
          Post newPost = Post(userId, id, title, body);
          _posts.add(newPost);
          _currMaxId = max(_currMaxId, id);
        });
      }
      _isError = false;
      notifyListeners();
    } catch (_) {
      _isError = true;
      notifyListeners();
    }
  }

  void updatePost(Post oldPost, Post newPost) {
    int indexOldPost = _posts.indexOf(oldPost);
    _posts[indexOldPost] = newPost;
    notifyListeners();
  }

  void addPost(String title, String body) {
    Post newPost = Post(_currUserId, ++_currMaxId, title, body);
    _posts.add(newPost);
    notifyListeners();
  }

  List<Post> get getPosts {
    return _posts;
  }

  int get getCurrUserId {
    return _currUserId;
  }

  bool get getIsError {
    return _isError;
  }
}
