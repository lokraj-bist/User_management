import 'package:flutter/material.dart';
import 'package:localnetwork/models/user.dart';

class CommentWidget extends StatelessWidget {
  final List<Comment> comments;

   CommentWidget({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Color(0xFF3C4662),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: comments.map((comment) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                comment.name[0].toUpperCase(),
                style:  TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              comment.name,
              style:  TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              comment.body,
              style:  TextStyle(color: Colors.white70),
            ),
          );
        }).toList(),
      ),
    );
  }
}
