import 'package:flutter/material.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({super.key});

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 400, top: 50),
      child: Row(
        children: [
          Image.asset('assets/images/profile_picture_icon.png',
              width: 350, height: 350),
          Container(
            margin: const EdgeInsets.only(left: 150),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Abhinav Mishra', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
                Text('Student', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
                Text('Indian Institute of Information Technology, Guwahati', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
