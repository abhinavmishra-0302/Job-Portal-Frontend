class Job {
  final String title;
  final String company;
  final String description;
  final String location;
  final String industry;
  final String employmentType;
  final String salary;
  final DateTime postedDate;
  final DateTime expiryDate;
  final String postedBy;
  final List<String> skills;
  final List<String> requirements;
  final List<String> responsibilities;

  Job({
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.industry,
    required this.employmentType,
    required this.salary,
    required this.postedDate,
    required this.expiryDate,
    required this.postedBy,
    required this.skills,
    required this.requirements,
    required this.responsibilities,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'],
      company: json['company'],
      description: json['description'],
      location: json['location'],
      industry: json['industry'],
      employmentType: json['employmentType'],
      salary: json['salary'],
      postedDate: DateTime.parse(json['postedDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      postedBy: json['postedBy'],
      skills: List<String>.from(json['skills']),
      requirements: List<String>.from(json['requirements']),
      responsibilities: List<String>.from(json['responsibilities']),
    );
  }
}