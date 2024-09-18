import 'package:api/model/people%20model.dart';
import 'package:api/services/user%20services.dart';
import 'package:flutter/material.dart';

class DesuupUserPage extends StatefulWidget {
  const DesuupUserPage({super.key});

  @override
  State<DesuupUserPage> createState() => _DesuupUserPageState();
}

class _DesuupUserPageState extends State<DesuupUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff84a59d),
        title: Text("Dsp Students"),
        centerTitle: true,
      ),
      body: FutureBuilder<PeopleModel?>(
        future: UserServices().fetchPeopleData(15),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.70, // Adjust the ratio as needed
              ),
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                final person = snapshot.data!.results![index];

                // Access the location properties from the person object
                final location = person.location;
                final locationDetails =
                    '${location?.city},${location?.state} , ${location?.country}';

                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(person.picture?.thumbnail ?? ''),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Name:${person.name?.first} ${person.name?.last}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text('Email:${person.email}'),
                        SizedBox(height: 5),
                        Text('Phone:${person.phone}'),
                        SizedBox(
                          height: 3,
                        ),
                        Text('Location:${locationDetails}'),
                      ],
                    ),
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
