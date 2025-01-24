import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:localnetwork/screens/post_screen.dart';
import '../database_handler/user_handler.dart';

class NativeUsers extends StatefulWidget {
  @override
  _LocalsScreenState createState() => _LocalsScreenState();
}

class _LocalsScreenState extends State<NativeUsers> {
  late Future<List<Map<String, dynamic>>> _favoriteUsers;
  DatabaseHelper dbhelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _favoriteUsers = dbhelper.fetchUsers();
  }


  void _removeUser(int id) async {
    await dbhelper.deleteUser(id);
    setState(() {
      _favoriteUsers = dbhelper.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Natives',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF252c4a),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _favoriteUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: SelectableText('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              "No favorite users found",
              style: TextStyle(color: Colors.white),
            ));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        IconlyBold.profile,
                        size: 35,
                      )),
                  title: Text(user['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(user['email'],
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(IconlyBold.arrowRightCircle,
                            color: Colors.grey[200]),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostsScreen(userId: user['id']),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _removeUser(user['id']),
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
  }
}
