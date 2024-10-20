import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:job_portal/screens/dashboard.dart';
import 'package:job_portal/screens/home_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedUserType = 'Job Seeker'; // Default user type
  final _formKey = GlobalKey<FormState>();

  DateTime? dobDate;
  DateTime? establishedDate;

  // Controllers for common fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Gender field
  String selectedGender = 'Male'; // Default gender selection

  // Controllers for job seeker specific fields
  final TextEditingController seekerHeadlineController = TextEditingController();
  final TextEditingController seekerPositionController = TextEditingController();
  final TextEditingController seekerCompanyController = TextEditingController();
  final TextEditingController seekerSummaryController = TextEditingController();

  // Controllers for employer specific fields
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyHeadquarterController = TextEditingController();
  final TextEditingController companyDescriptionController = TextEditingController();
  final TextEditingController companyWebsiteController = TextEditingController();
  final TextEditingController companyIndustryController = TextEditingController();
  final TextEditingController companySizeController = TextEditingController();
  final TextEditingController companyEmployerRoleController = TextEditingController();
  final TextEditingController companyEstablishedController = TextEditingController();

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dobDate ?? DateTime.now(), // Default to today if no date is selected
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date is today
    );
    if (pickedDate != null && pickedDate != dobDate) {
      setState(() {
        if (type == 'dob') {
          dobDate = pickedDate;
          dobController.text = DateFormat('yyyy-MM-dd').format(dobDate!); // Format the date
        }
        else if (type == 'company_established') {
          establishedDate = pickedDate;
          companyEstablishedController.text = DateFormat('yyyy-MM-dd').format(establishedDate!); // Format the date
        }

      });
    }
  }

  Future<void> _submitJobSeekerData() async {
    if (_formKey.currentState!.validate()) {
      // Gather job seeker data
      final jobSeekerData = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'dateOfBirth': dobController.text,
        'gender': selectedGender,
        'phoneNumber': phoneController.text,
        'headline': seekerHeadlineController.text,
        'currentPosition': seekerPositionController.text,
        'company': seekerCompanyController.text,
        'professionalSummary': seekerSummaryController.text,
      };

      final authData = {
        'username': usernameController.text,
        'password': passwordController.text,
      };

      const String profileUrl = 'http://localhost:8082/api/v1/job-seeker-profiles'; // Update this with the correct endpoint
      const String authUrl = 'http://localhost:8080/api/v1/auth/register'; // Update this with the correct endpoint

      try {
        final response = await http.post(
          Uri.parse(profileUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(jobSeekerData),
        );

        if (response.statusCode == 200) {
          // Success handling (e.g., navigate to another screen)
          print('Job seeker signed up successfully!');
        } else {
          // Error handling (e.g., display error message)
          print('Failed to sign up. Error: ${response.statusCode}');
        }
      } catch (e) {
        // Exception handling
        print('An error occurred: $e');
      }

      try{
        final authResponse = await http.post(
          Uri.parse(authUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(authData),
        );

        if (authResponse.statusCode == 200) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          print('Job seeker signed up successfully!');
        } else {
          // Error handling (e.g., display error message)
          print('Failed to sign up. Error: ${authResponse.statusCode}');
        }
      } catch (e) {
        // Exception handling
        print('An error occurred: $e');
      }
    }
  }

  Future<void> _submitEmployerData() async {
    if (_formKey.currentState!.validate()) {
      // Gather job seeker data
      final jobSeekerData = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'dateOfBirth': dobController.text,
        'gender': selectedGender,
        'phoneNumber': phoneController.text,
        'headline': seekerHeadlineController.text,
        'companyDescription': companyDescriptionController.text,
        'companyName': companyNameController.text,
        'companySize': companySizeController.text,
        'companyWebsite': companyWebsiteController.text,
        'employerRole': companyEmployerRoleController.text,
        'establishedOn': companyEstablishedController.text,
        'headquarters': companyHeadquarterController.text,
        'industry': companyIndustryController.text,
      };

      final authData = {
        'username': usernameController.text,
        'password': passwordController.text,
      };

      const String profileUrl = 'http://localhost:8082/api/v1/employer-profiles'; // Update this with the correct endpoint
      const String authUrl = 'http://localhost:8080/api/v1/auth/register'; // Update this with the correct endpoint

      try {
        final response = await http.post(
          Uri.parse(profileUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(jobSeekerData),
        );

        if (response.statusCode == 200) {
          print('Job seeker signed up successfully!');
        } else {
          // Error handling (e.g., display error message)
          print('Failed to sign up. Error: ${response.statusCode}');
        }
      } catch (e) {
        // Exception handling
        print('An error occurred: $e');
      }

      try{
        final authResponse = await http.post(
          Uri.parse(authUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(authData),
        );

        if (authResponse.statusCode == 200) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          print('Job seeker signed up successfully!');
        } else {
          // Error handling (e.g., display error message)
          print('Failed to sign up. Error: ${authResponse.statusCode}');
        }
      } catch (e) {
        // Exception handling
        print('An error occurred: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Dropdown for selecting user type
              DropdownButtonFormField<String>(
                value: selectedUserType,
                decoration: const InputDecoration(
                  labelText: 'Sign up as',
                ),
                items: ['Job Seeker', 'Employer'].map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUserType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Common fields
              TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your desired username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', suffix: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: dobController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  _selectDate(context, 'dob');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: phoneController,
                readOnly: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  suffixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Gender Radio Buttons
              const Text('Gender:'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Other'),
                      value: 'Other',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Job Seeker specific fields
              if (selectedUserType == 'Job Seeker') ...[
                TextFormField(
                  controller: seekerHeadlineController,
                  decoration: const InputDecoration(labelText: 'Headline'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your desired headline';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: seekerPositionController,
                  decoration: const InputDecoration(labelText: 'Current Position'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current position';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: seekerCompanyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: seekerSummaryController,
                  decoration: const InputDecoration(labelText: 'Your professional summary'),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your summary';
                    }
                    return null;
                  },
                ),
              ],

              // Employer specific fields
              if (selectedUserType == 'Employer') ...[
                TextFormField(
                  controller: companyNameController,
                  decoration: const InputDecoration(labelText: 'Company Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyHeadquarterController,
                  decoration: const InputDecoration(labelText: 'Company Headquarter'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the company quarter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyDescriptionController,
                  decoration: const InputDecoration(labelText: 'Company Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description of the company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyWebsiteController,
                  decoration: const InputDecoration(labelText: 'Company Website'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a website of the company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyIndustryController,
                  decoration: const InputDecoration(labelText: 'Industry'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide industry of your company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companySizeController,
                  decoration: const InputDecoration(labelText: 'Company Size'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide size of your company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyEmployerRoleController,
                  decoration: const InputDecoration(labelText: 'Employer Role'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide your role in the company';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: companyEstablishedController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Company Established On',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    _selectDate(context, 'company_established');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of establishment';
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedUserType == 'Job Seeker') {
                      _submitJobSeekerData();
                    } else {
                      _submitEmployerData();
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}