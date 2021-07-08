import 'package:flutter/material.dart';
import 'package:interview_project/pages/add-post-page.dart';
import 'package:interview_project/pages/edit-post-page.dart';
import 'package:interview_project/widgets/post-item.dart';
import 'package:provider/provider.dart';
import './providers/posts.dart';
import './models/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Posts())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Posts>(context, listen: false).loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<Posts>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return AddPostPage();
                  })))
        ],
      ),
      body: postData.getIsError
          ? Center(
              child: Column(
                children: [
                  Text("Connection issue occured. Please try again"),
                  ElevatedButton(
                      onPressed: () => postData.loadPosts(),
                      child: Text('Refresh'))
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return PostItem(postData.getPosts.reversed.toList()[index]);
                },
                itemCount: postData.getPosts.length,
              )),
    );
  }
}
