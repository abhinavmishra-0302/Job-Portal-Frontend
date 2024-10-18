import 'package:flutter/material.dart';

import '../model/job_application.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class JobApplicationsPage extends StatefulWidget {
  final String userId;
  final String jwtToken;

  const JobApplicationsPage({Key? key, required this.userId, required this.jwtToken}) : super(key: key);

  @override
  _JobApplicationsPageState createState() => _JobApplicationsPageState();
}

class _JobApplicationsPageState extends State<JobApplicationsPage> {
  late Future<List<JobApplication>> futureJobApplications;

  @override
  void initState() {
    super.initState();
    futureJobApplications = fetchJobApplications(widget.userId, widget.jwtToken);
  }

  Future<List<JobApplication>> fetchJobApplications(String userId, String jwtToken) async {
    final url = Uri.parse('http://localhost:8084/api/v1/job-application/user/$userId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYmhpbmF2MDMwMkBnbWFpbC5jb20iLCJleHAiOjE3MjYxMDEwNTksImlhdCI6MTcyNjA2NTA1OX0.LRZx6ORNjsQIah22QSqEb3foDdx49MTUZc3_1GA1S10',
    });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => JobApplication.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load job applications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Job Applications',
          style: TextStyle(
              fontFamily: 'Oswald Bold',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<JobApplication>>(
        future: futureJobApplications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No job applications found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final application = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(application.jobTitle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${application.status}'),
                        Text('Applied at: ${application.appliedAt.toLocal()}'),
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
