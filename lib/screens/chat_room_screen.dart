import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _showExtraButtons = false;

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text.trim(),
          'sent': true,
        });
        _controller.clear();
      });
    }
  }

  void _toggleExtraButtons() {
    setState(() {
      _showExtraButtons = !_showExtraButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('🦁', style: TextStyle(fontSize: 24)),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '멋쟁이 사자처럼 12기',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['sent'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: message['sent'] ? Colors.purple[200] : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: message['sent'] ? Colors.purple : Colors.grey[300] ?? Colors.grey,
                      ),
                    ),
                    child: Text(message['text']),
                  ),
                );
              },
            ),
          ),
          if (_showExtraButtons)
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.insert_drive_file), onPressed: () {}),
                    IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
                    IconButton(icon: Icon(Icons.photo), onPressed: () {}),
                    IconButton(icon: Icon(Icons.location_on), onPressed: () {}),
                    IconButton(icon: Icon(Icons.mic), onPressed: () {}),
                    IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: _toggleExtraButtons,
                ),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
