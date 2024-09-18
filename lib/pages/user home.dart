
import 'package:api/model/user%20model.dart';
import 'package:api/services/user%20services.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome ({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Users"),
        centerTitle: true,
      ),
      body:FutureBuilder<List<UserModel>>(
        future: UserServices().fetchUserData(100),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title:
                  Text("${user.tittle} ${user.first} ${user.last} "),
                );
              },
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),


    );
  }
}
