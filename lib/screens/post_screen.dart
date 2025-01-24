import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:localnetwork/models/user.dart';
import 'package:localnetwork/services/user_fetch.dart';
import '../widgets/comment_widget.dart';
class PostsScreen extends StatefulWidget {
  final int userId;

  PostsScreen({required this.userId});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<Post>> _posts;
  Map<int, bool> _showComments = {};

  @override
  void initState() {
    super.initState();
    _posts = ApiService.fetchPosts(widget.userId);
  }

  Future<void> _toggleComments(int postId) async {
    setState(() {
      _showComments[postId] = !(_showComments[postId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconlyBold.arrowLeftCircle,
              color: Colors.white,
            )),
        title: Text(
          'Posts',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF252c4a),
      ),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final postId = post.id;
                final showComments = _showComments[postId] ?? false;

                return Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFF313A5D),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          post.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          post.body,
                          style: TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              showComments
                                  ? Icons.comment_bank
                                  : Icons.comment_outlined,
                              color: showComments
                                  ? Colors.red
                                  : Colors.white70,
                              size: 28,
                            ),
                            onPressed: () => _toggleComments(postId),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      if (showComments)
                        FutureBuilder<List<Comment>>(
                          future: ApiService.fetchComments(postId),

                          builder: (context, commentsSnapshot) {
                            if (commentsSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                    radius: 10,
                                  ));
                            } else if (commentsSnapshot.hasError) {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Error loading comments',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              );
                            } else {
                              final comments = commentsSnapshot.data!;
                              return CommentWidget(comments: comments,);
                            }
                          },
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }}
