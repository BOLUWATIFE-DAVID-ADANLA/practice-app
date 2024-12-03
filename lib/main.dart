import 'package:flutter/material.dart';
import 'package:practice_app/api.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: getAllTeams(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var teams = snapshot.data!;
                return ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (BuildContext context, int index) {
                    var team = teams[index];
                    return ListTile(
                      title: Text(team.fullName),
                      subtitle: Row(
                        children: [
                          Text(team.abbreviation),
                          Text('(${team.city})'),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Text('there was an error fetching the teams');
              }
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
