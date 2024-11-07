import 'package:flutter/material.dart';
import 'package:job_portal/screens/job_applications.dart';

import 'create_job.dart';

class EmployerDashboard extends StatelessWidget {
  final List<Map<String, String>> jobList = [
    {'title': 'Software Developer', 'status': 'Open', 'date': '2024-11-01'},
    {'title': 'Project Manager', 'status': 'Closed', 'date': '2024-10-28'},
    {'title': 'UI/UX Designer', 'status': 'Open', 'date': '2024-11-03'},
    {'title': 'Data Scientist', 'status': 'Open', 'date': '2024-11-05'},
  ]; // Replace with data fetching logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Create Job'),
              onTap: () {
                // Navigate to job creation
                print('Navigate to job creation page');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings
                print('Navigate to settings page');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout functionality
                print('Logged out');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Job Listings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: jobList.length,
                itemBuilder: (context, index) {
                  final job = jobList[index];
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => JobApplicationsPage(jobId: 1)));
                    },
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['title'] ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status: ${job['status']}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.indigo),
                                  onPressed: () {
                                    // Edit job function
                                    print('Edit job: ${job['title']}');
                                  },
                                ),
                              ],
                            ),
                            Text(
                              'Date: ${job['date']}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to job creation form
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => CreateJobPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Job'),
        tooltip: 'Create New Job',
      ),
    );
  }
}
