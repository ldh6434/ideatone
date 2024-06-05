import 'package:flutter/material.dart';

class NfcCheckinLogScreen extends StatelessWidget {
  final List<Map<String, String>> logs = [
    {'type': 'error', 'message': 'NFC not allowed', 'timestamp': '2024.6.6. 오전 1:08:55'},
    {'type': 'success', 'message': '출입자: Admin (1111111)', 'timestamp': '2024.6.6. 오전 1:09:09'},
    {'type': 'error', 'message': 'NFC not allowed', 'timestamp': '2024.6.6. 오전 1:09:12'},
    {'type': 'success', 'message': '출입자: 아사기자 (2020124)', 'timestamp': '2024.6.6. 오전 1:09:30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC 체크인 로그'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_box, color: Colors.green),
                SizedBox(width: 8),
                Text('동아리방 출입 체크', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: log['type'] == 'error' ? Colors.red[50] : Colors.blue[50],
                        border: Border.all(
                          color: log['type'] == 'error' ? Colors.red : Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log['message']!,
                            style: TextStyle(
                              color: log['type'] == 'error' ? Colors.red : Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(log['timestamp']!),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('사용자 등록'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('맨 위로'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}