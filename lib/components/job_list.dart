import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:job_portal/model/job.dart';

class JobList extends StatefulWidget {
  final double height;

  const JobList({required this.height, super.key}); // Fixed the constructor

  @override
  State<JobList> createState() => _JobListState();
}


class _JobListState extends State<JobList> {

  Future<List<Job>> fetchJobs() async {
    final response = await http.get(
      Uri.parse('http://localhost:8081/api/v1/jobs'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jobList = jsonDecode(response.body);
      return jobList.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height - 300,
      child: FutureBuilder<List<Job>>(
        future: fetchJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No jobs available.'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Job job = snapshot.data![index];
                return ListTile(
                  title: Text(
                    job.title,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.company),
                      Text(job.location),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                );
              },
            );
          } else {
            return const Center(child: Text('Unknown error occurred.'));
          }
        },
      ),
    );
  }
}
