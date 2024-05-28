import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('어떤 분야를', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('좋아하세요?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  CategoryItem(
                    imagePath: 'assets/images/microphone.png',
                    label: '노래 / 밴드',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/soccer.png',
                    label: '스포츠',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/computer.png',
                    label: '코딩',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/beer.png',
                    label: '파티',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/book.png',
                    label: '학술',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/pizza.png',
                    label: '음식 / 카페',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/trophy.png',
                    label: '공모전 / 대회',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/church.png',
                    label: '종교',
                  ),
                  CategoryItem(
                    imagePath: 'assets/images/sunglasses.png',
                    label: '패션',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/club_list');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;

  CategoryItem({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/club_list');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
