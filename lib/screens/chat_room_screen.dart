import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _showExtraButtons = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesString = prefs.getString('messages');
    if (messagesString != null) {
      List<dynamic> messagesJson = jsonDecode(messagesString);
      setState(() {
        _messages.clear();
        _messages.addAll(messagesJson.map((json) => Map<String, dynamic>.from(json)).toList());
      });
    }
  }

  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messagesString = jsonEncode(_messages);
    await prefs.setString('messages', messagesString);
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text.trim(),
          'sent': true,
        });
        _controller.clear();
        _focusNode.requestFocus();
      });
      _saveMessages();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _toggleExtraButtons() {
    setState(() {
      _showExtraButtons = !_showExtraButtons;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
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
                '사자 동아리',
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
              controller: _scrollController,
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
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (value) {
                      _sendMessage();
                    },
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
