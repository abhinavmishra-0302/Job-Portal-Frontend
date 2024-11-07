import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateJobPage extends StatefulWidget {
  @override
  _CreateJobPageState createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  final _formKey = GlobalKey<FormState>();
  String jobTitle = '';
  String jobDescription = '';
  String company = '';
  String location = '';
  String industry = 'Technology';
  String employmentType = 'Full-Time';
  double salary = 0.0;
  DateTime? postedDate;
  DateTime? expiryDate;
  List<String> skills = [];
  List<String> requirements = [];
  List<String> responsibilities = [];
  int postedBy = 101; // Replace with dynamic user ID as needed

  final List<String> employmentTypes = ['Full-Time', 'Part-Time', 'Contract', 'Internship'];
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController responsibilitiesController = TextEditingController();

  Future<void> _submitJob() async {
    final url = Uri.parse('http://localhost:8081/api/v1/jobs');
    final body = jsonEncode({
      "title": jobTitle,
      "description": jobDescription,
      "company": company,
      "location": location,
      "industry": industry,
      "employmentType": employmentType,
      "salary": salary,
      "postedDate": DateTime.now().toIso8601String(),
      "expiryDate": DateTime.now().add(const Duration(days: 30)).toIso8601String(), // Example expiry date
      "skills": skills,
      "requirements": requirements,
      "responsibilities": responsibilities,
      "postedBy": postedBy,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job "$jobTitle" created successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create job: ${response.reasonPhrase}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
                onSaved: (value) {
                  jobTitle = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Job Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
                onSaved: (value) {
                  jobDescription = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company name';
                  }
                  return null;
                },
                onSaved: (value) {
                  company = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  location = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: employmentType,
                decoration: const InputDecoration(
                  labelText: 'Employment Type',
                  border: OutlineInputBorder(),
                ),
                items: employmentTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    employmentType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Salary',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid salary';
                  }
                  return null;
                },
                onSaved: (value) {
                  salary = double.parse(value ?? '0');
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: skillsController,
                decoration: const InputDecoration(
                  labelText: 'Skills (comma separated)',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    skills = value.split(',').map((e) => e.trim()).toList();
                  });
                  skillsController.clear();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: requirementsController,
                decoration: const InputDecoration(
                  labelText: 'Requirements (comma separated)',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    requirements = value.split(',').map((e) => e.trim()).toList();
                  });
                  requirementsController.clear();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: responsibilitiesController,
                decoration: const InputDecoration(
                  labelText: 'Responsibilities (comma separated)',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    responsibilities = value.split(',').map((e) => e.trim()).toList();
                  });
                  responsibilitiesController.clear();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitJob();
                  }
                },
                child: const Text('Create Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
