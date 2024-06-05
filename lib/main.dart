import 'package:flutter/material.dart';
import 'screens/calendar_screen.dart';
import 'screens/chat_room_screen.dart';
import 'screens/club_list_screen.dart';
import 'screens/friend_add_screen.dart';
import 'screens/profile_form_screen.dart';
import 'screens/selection_screen.dart';
import 'screens/nfc_check_in_log_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SelectionScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/chat_room': (context) => ChatRoomScreen(),
        '/club_list': (context) => ClubListScreen(),
        '/friend_add': (context) => FriendAddScreen(),
        '/profile_form': (context) => ProfileFormScreen(),
        '/nfc_check_in_log': (context) => NfcCheckinLogScreen(),
      },
    );
  }
}