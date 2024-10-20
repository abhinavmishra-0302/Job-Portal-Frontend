class JobSeekerProfile {
  final num id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;
  final DateTime dateOfBirth;
  final String gender;

  final String headline;
  final String currentPosition;
  final String company;
  final String professionalSummary;
  final String resumeUrl;
  final List<String> skills;

  JobSeekerProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.dateOfBirth,
    required this.gender,
    required this.headline,
    required this.currentPosition,
    required this.company,
    required this.professionalSummary,
    required this.resumeUrl,
    required this.skills,
  });

  factory JobSeekerProfile.fromJson(Map<String, dynamic> json) {

    var jobSeeker = JobSeekerProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePictureUrl: '',
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      headline: json['headline'],
      skills: [],
      currentPosition: json['currentPosition'],
      company: json['company'],
      professionalSummary: json['professionalSummary'],
      resumeUrl: '',
    );

    return jobSeeker;
  }

}
