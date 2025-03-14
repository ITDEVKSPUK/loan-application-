import 'package:flutter/material.dart';
import 'package:loan_apllication/widgets/survey_box.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> surveyList = [
    {
      'name': 'Azzam Aqila',
      'date': '20th February 2036',
      'location': 'Kudus, Jawa Utara',
      'status': 'ACCEPTED',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Nadira Salsabila',
      'date': '15th March 2036',
      'location': 'Semarang, Jawa Tengah',
      'status': 'DECLINED',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Rizky Fadillah',
      'date': '10th April 2036',
      'location': 'Jakarta, DKI Jakarta',
      'status': 'UNREAD',
      'image': 'assets/images/bg.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 57,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Survey List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: surveyList.length,
              itemBuilder: (context, index) {
                final item = surveyList[index];
                return SurveyBox(
                  name: item['name']!,
                  date: item['date']!,
                  location: item['location']!,
                  status: item['status']!,
                  image: item['image']!,
                  statusColor: getStatusColor(item['status']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'ACCEPTED':
        return Color.fromRGBO(102, 217, 150, 1);
      case 'DECLINED':
        return Color.fromRGBO(227, 31, 31, 1);
      case 'UNREAD':
        return Color.fromRGBO(227, 135, 31, 1);
      default:
        return Colors.grey;
    }
  }
}
