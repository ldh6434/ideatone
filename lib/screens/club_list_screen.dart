import 'package:flutter/material.dart';
import 'club_detail_screen.dart'; // ClubDetailScreen 파일을 import

class ClubListScreen extends StatefulWidget {
  @override
  _ClubListScreenState createState() => _ClubListScreenState();
}

class _ClubListScreenState extends State<ClubListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _clubs = [
    {'emoji': '🦁', 'name': '사자 동아리', 'reviews': '★★★★★ / 후기 200개'},
    {'emoji': '🐱', 'name': '고양이 동아리', 'reviews': '★★★★☆ / 후기 180개'},
    {'emoji': '🐻', 'name': '두산 동아리', 'reviews': '★★★★★ / 후기 300개'},
    {'emoji': '👯', 'name': '쌍둥이 동아리', 'reviews': '★★★☆☆ / 후기 100개'},
    {'emoji': '🐯', 'name': '호랑이 동아리', 'reviews': '★★★★☆ / 후기 150개'},
    {'emoji': '💩', 'name': '똥 덩어리', 'reviews': '★★☆☆☆ / 후기 35개'},
  ];
  late List<Map<String, String>> _filteredClubs;

  @override
  void initState() {
    super.initState();
    _filteredClubs = _clubs;
    _searchController.addListener(() {
      setState(() {
        _filteredClubs = _clubs.where((club) {
          return club['name']!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
              club['reviews']!.toLowerCase().contains(_searchController.text.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동아리 앱'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '동아리 이름, 내용, 분야',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('인기순'),
                  Text('별점 높은 순'),
                  Text('최신순'),
                  Text('후기 많은 순'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _filteredClubs.map((club) {
                return ClubItem(
                  emoji: club['emoji']!,
                  name: club['name']!,
                  reviews: club['reviews']!,
                  onApply: () {
                    _showApplyDialog(context, club['name']!);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubDetailScreen(
                          emoji: club['emoji']!,
                          name: club['name']!,
                          reviews: club['reviews']!,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/calendar');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chat_room');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/friend_add');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile_form');
          }
        },
      ),
    );
  }

  void _showApplyDialog(BuildContext context, String clubName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('$clubName 신청되었습니다!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

class ClubItem extends StatelessWidget {
  final String emoji;
  final String name;
  final String reviews;
  final VoidCallback onApply;
  final VoidCallback onTap;

  ClubItem({
    required this.emoji,
    required this.name,
    required this.reviews,
    required this.onApply,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(emoji, style: TextStyle(fontSize: 24)),
      title: Text(name),
      subtitle: Text(reviews),
      trailing: ElevatedButton(
        onPressed: onApply,
        child: Text('신청'),
      ),
      onTap: onTap, // 제목을 눌렀을 때 상세 화면으로 이동하도록 설정
    );
  }
}
