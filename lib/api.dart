import 'package:dio/dio.dart';

// get put post deelte
final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 3),
    receiveTimeout: const Duration(seconds: 3),
    headers: {'Authorization': '7cea9b58-19d7-4076-b365-0f1a4b94c9cb'}));

Future<List<Team>> getAllTeams() async {
  final respones = await dio.get('https://api.balldontlie.io/v1/teams');
  if (respones.statusCode == 200 ||
      respones.data['success'] && respones.data != null) {
    final List<dynamic> teamsdata = respones.data['data'];
    final List<Team> teams =
        teamsdata.map((team) => Team.fromMap(team)).toList();
    print(teams.length);
    print(teams);
    return teams;
  }

  throw 'there was an error';
}

class Team {
  final int id;
  final String fullName;
  final String abbreviation;
  final String city;

  // Constructor
  Team({
    required this.id,
    required this.fullName,
    required this.abbreviation,
    required this.city,
  });

  // Factory method to create a Team object from a map (API response)
  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      fullName: map['full_name'],
      abbreviation: map['abbreviation'],
      city: map['city'],
    );
  }

  @override
  String toString() {
    return 'Team: $fullName ($abbreviation) - $city';
  }
}
