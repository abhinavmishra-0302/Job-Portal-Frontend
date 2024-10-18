class JobApplication {
  final int id;
  final int jobId;
  final int userId;
  final String jobTitle;
  final String status;
  final String resumeUrl;
  final String coverLetter;
  final DateTime appliedAt;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.jobTitle,
    required this.status,
    required this.resumeUrl,
    required this.coverLetter,
    required this.appliedAt,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'],
      jobId: json['jobId'],
      userId: json['userId'],
      jobTitle: json['jobTitle'],
      status: json['status'],
      resumeUrl: json['resumeUrl'],
      coverLetter: json['coverLetter'],
      appliedAt: DateTime.parse(json['appliedAt']),
    );
  }
}
