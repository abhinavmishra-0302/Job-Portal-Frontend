import 'package:flutter/material.dart';
import 'package:job_portal/components/job_list.dart';
import 'package:job_portal/components/profile_summary.dart';
import 'package:job_portal/screens/user_applications.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).viewPadding.bottom -
        MediaQuery.of(context).viewInsets.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: 'Oswald Bold',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const JobApplicationsPage(
                    userId: '3',
                    jwtToken: 'token',
                  ),
                ));
              },
              child: const Text("My Applications"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("My Profile"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView to allow scrolling
        child: Column(
          children: [
            const ProfileSummary(),
            Container(
              margin: const EdgeInsets.only(left: 50, top: 50, bottom: 50),
              child: const Text(
                "Jobs for you",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            JobList(height: height)
          ],
        ),
      ),
    );
  }
}
