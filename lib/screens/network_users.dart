import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:localnetwork/services/user_fetch.dart';
import '../../models/user.dart';
import '../database_handler/user_handler.dart';
import 'post_screen.dart';

class NetworkScreen extends StatefulWidget {
  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late Future<List<User>> _usersFuture;
  DatabaseHelper dbhelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _usersFuture = ApiService.fetchUsers();
  }

  void _saveFavoriteUser(User user) async {
    final favoriteUser = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
    };

    await dbhelper.insertUser(favoriteUser);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              IconlyBold.arrowRightCircle,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              '${user.name} stored in database',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Color(0xFF394867),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Users',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF252c4a),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No user found'));
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
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_box_rounded, color: Colors.grey[200]),
                        onPressed: () => _saveFavoriteUser(user),
                      ),
                      IconButton(
                        icon: Icon(IconlyBold.arrowRightCircle, color: Colors.grey[200]),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostsScreen(userId: user.id),
                            ),
                          );
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
  }
}
