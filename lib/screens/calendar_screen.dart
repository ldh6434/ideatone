import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedMonth = DateTime
      .now()
      .month;

  final Map<int, List<Map<String, dynamic>>> _events = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [
      {
        'day': 9,
        'title': '멋쟁이사자처럼',
        'time': '오후 7 - 10시',
        'location': '전자관 419호',
        'color': Colors.red
      },
      {
        'day': 16,
        'title': 'FC 항공',
        'time': '오후 6 - 9시',
        'location': '대운동장',
        'color': Colors.blue
      },
    ],
    6: [],
    7: [],
    8: [],
    9: [],
    10: [],
    11: [],
    12: [],
  };

  @override
  Widget build(BuildContext context) {
    List<int> eventDays = _events[_selectedMonth]
        ?.map((e) => e['day'] as int)
        .toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('이달의 동아리', style: TextStyle(fontFamily: 'NotoSans')),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '동아리 일정', style: TextStyle(fontFamily: 'NotoSans')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '개인 일정', style: TextStyle(fontFamily: 'NotoSans')),
                ),
              ],
              isSelected: [true, false],
              onPressed: (int index) {},
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: _selectedMonth > 1
                        ? () => setState(() => _selectedMonth--)
                        : null),
                Text('${_selectedMonth}월',
                    style: TextStyle(fontSize: 18, fontFamily: 'NotoSans')),
                IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: _selectedMonth < 12
                        ? () => setState(() => _selectedMonth++)
                        : null),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: DateTime(2024, _selectedMonth + 1, 0).day,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                int day = index + 1;
                bool isEventDay = eventDays.contains(day);
                Color dotColor = Colors.transparent;

                if (isEventDay) {
                  var event = _events[_selectedMonth]
                      ?.firstWhere((e) => e['day'] == day,
                      orElse: () => {'color': Colors.transparent});
                  dotColor = event?['color'];
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$day', style: TextStyle(
                          fontSize: 16, fontFamily: 'NotoSans')),
                      SizedBox(height: 4),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: dotColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _events[_selectedMonth]?.map((event) {
                  return EventItem(
                    color: event['color'],
                    title: event['title'],
                    time: event['time'],
                    location: event['location'],
                  );
                }).toList() ?? [],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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


class EventItem extends StatelessWidget {
  final Color color;
  final String title;
  final String time;
  final String location;

  EventItem({required this.color, required this.title, required this.time, required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
      ),
      title: Text(title, style: TextStyle(fontFamily: 'NotoSans')),
      subtitle: Text('$time · $location', style: TextStyle(fontFamily: 'NotoSans')),
    );
  }
}

