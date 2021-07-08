import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../models/post.dart';

class EditPostPage extends StatefulWidget {
  Post _post;

  EditPostPage(this._post);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  String _currentUserId = '';
  String _currentId = '';
  String _currentTitle = '';
  String _currentBody = '';

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _currentUserId = widget._post.userId.toString();
    _currentId = widget._post.id.toString();
    _currentTitle = widget._post.title;
    _currentBody = widget._post.body;

    _titleController.text = _currentTitle;
    _bodyController.text = _currentBody;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              _buildInfoDisplay(),
              _buildSectionTitle('Post Title'),
              _buildTextInputfield(_titleController),
              _buildSectionTitle('Body'),
              _buildTextInputfield(_bodyController),
              _buildSaveButton(context)
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoDisplay() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'User ID: $_currentUserId',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Post ID: $_currentId',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextInputfield(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: ElevatedButton(
            onPressed: () => _updatePost(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Save Changes',
                style: TextStyle(fontSize: 20),
              ),
            )));
  }

  void _updatePost(BuildContext context) {
    Post newPost = Post(widget._post.userId, widget._post.id,
        _titleController.text, _bodyController.text);
    Provider.of<Posts>(context, listen: false)
        .updatePost(widget._post, newPost);
    Navigator.of(context).pop();
  }
}
