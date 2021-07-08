import 'package:flutter/material.dart';
import 'package:interview_project/pages/edit-post-page.dart';
import '../models/post.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../models/post.dart';

class PostItem extends StatelessWidget {
  Post _post;

  PostItem(this._post);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return EditPostPage(_post);
      })),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _post.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text('User ID: ${_post.userId.toString()}'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Post ID: ${_post.id.toString()}'),
                  ],
                ),
              ),
              Text(_post.body),
            ],
          ),
        ),
      ),
    );
  }
}
