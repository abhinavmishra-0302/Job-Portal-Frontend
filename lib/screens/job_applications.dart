import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobApplicationsPage extends StatefulWidget {
  final int jobId; // Pass the job ID to fetch applicants for this job

  JobApplicationsPage({required this.jobId});

  @override
  _JobApplicationsPageState createState() => _JobApplicationsPageState();
}

class _JobApplicationsPageState extends State<JobApplicationsPage> {
  List<Map<String, dynamic>> applicants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApplicants();
  }

  Future<void> fetchApplicants() async {
    final url = Uri.parse('http://localhost:8081/api/v1/jobs/${widget.jobId}/applicants');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          applicants = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load applicants: ${response.reasonPhrase}')),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Applicants'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : applicants.isEmpty
          ? Center(child: Text('No applicants found.'))
          : ListView.builder(
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(applicant['name'] ?? 'Unknown Applicant'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${applicant['email'] ?? 'N/A'}'),
                  Text('Experience: ${applicant['experience']} years'),
                  Text('Skills: ${(applicant['skills'] as List).join(', ')}'),
                ],
              ),
              onTap: () {
                // Navigate to a detailed applicant profile if needed
                print('View details of ${applicant['name']}');
              },
            ),
          );
        },
      ),
    );
  }
}