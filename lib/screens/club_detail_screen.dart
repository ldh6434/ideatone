import 'package:flutter/material.dart';

class ClubDetailScreen extends StatelessWidget {
  final String emoji;
  final String name;
  final String reviews;

  ClubDetailScreen({required this.emoji, required this.name, required this.reviews});

  final List<Map<String, String>> sampleReviews = [
    {'reviewer': '홍길동', 'review': '정말 재미있는 동아리입니다! 추천해요.'},
    {'reviewer': '김철수', 'review': '활동이 다양하고 유익해요.'},
    {'reviewer': '이영희', 'review': '분위기가 좋아서 자주 참여하고 있어요.'},
    {'reviewer': '박민수', 'review': '친구들도 많고 정말 좋아요!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 64),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nfc_check_in_log');
                  },
                  icon: Icon(Icons.nfc, size: 24),
                  label: Text('NFC 출입 로그 확인'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '후기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              reviews,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sampleReviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sampleReviews[index]['reviewer']!),
                    subtitle: Text(sampleReviews[index]['review']!),
                    leading: Icon(Icons.person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
