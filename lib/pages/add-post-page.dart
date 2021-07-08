import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts.dart';
import '../models/post.dart';

class AddPostPage extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Text(
                  'User ID: ${Provider.of<Posts>(context).getCurrUserId.toString()}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
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
            onPressed: () => _submitPost(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            )));
  }

  void _submitPost(context) {
    Provider.of<Posts>(context, listen: false)
        .addPost(_titleController.text, _bodyController.text);
    Navigator.of(context).pop();
  }
}
