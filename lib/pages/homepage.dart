import 'package:api/model/people%20model.dart';
import 'package:api/services/user%20services.dart';
import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   FutureBuilder<PeopleModel?>(
          future: UserServices().fetchPeopleData(200),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  final person = snapshot.data!.results![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      NetworkImage(person.picture?.thumbnail ?? ''),
                    ),
                    title: Text('${person.name?.first} ${person.name?.last}'),
                    subtitle: Text(person.email ?? ''),
                  );
                },
              );
            }
          },
        )


    );
  }
}
