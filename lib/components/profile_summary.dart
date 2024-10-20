
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/job_seeker_profile.dart';

class ProfileSummary extends StatefulWidget {
  final String username;

  const ProfileSummary({required this.username, super.key});

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  late Future<JobSeekerProfile> jobSeekerProfile;

  Future<JobSeekerProfile> fetchProfile() async {
    final response = await http.get(
      Uri.parse('http://localhost:8082/api/v1/job-seeker-profiles/username/${widget.username}'),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var jobSeeker = JobSeekerProfile.fromJson(responseData);
      return jobSeeker;
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  void initState() {
    jobSeekerProfile = fetchProfile(); // Initialize the future
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 400, top: 50),
      child: FutureBuilder<JobSeekerProfile>(
        future: jobSeekerProfile, // Use the future here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a circular progress indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurs, show the error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // When the data is available, display the profile summary
            JobSeekerProfile profile = snapshot.data!;
            return Row(
              children: [
                Image.asset('assets/images/profile_picture_icon.png',
                    width: 350, height: 350),
                Container(
                  margin: const EdgeInsets.only(left: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${profile.firstName} ${profile.lastName}',
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold)),
                      Text(profile.currentPosition,
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold)),
                      Text(profile.company,
                          style: const TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // In case of no data
            return const Center(child: Text('No profile data available.'));
          }
        },
      ),
    );
  }
}