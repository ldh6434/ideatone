import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddEvent;

  AddEventScreen({required this.onAddEvent});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _time = '';
  String _location = '';
  Color _color = Colors.red;
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동아리 일정 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                '일정 추가하기',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '제목',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '시간',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '시간을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _time = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '장소',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '장소를 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  "날짜: ${_dateFormat.format(_selectedDate)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.calendar_today, color: Colors.blue),
                onTap: _pickDate,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<Color>(
                value: _color,
                items: [
                  DropdownMenuItem(
                    child: Text('빨간색'),
                    value: Colors.red,
                  ),
                  DropdownMenuItem(
                    child: Text('파란색'),
                    value: Colors.blue,
                  ),
                  DropdownMenuItem(
                    child: Text('초록색'),
                    value: Colors.green,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _color = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: '색상',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onAddEvent({
                      'title': _title,
                      'time': _time,
                      'location': _location,
                      'color': _color,
                      'day': _selectedDate.day,
                      'month': _selectedDate.month,
                      'year': _selectedDate.year,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('추가', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
