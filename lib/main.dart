import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alarm App'),
        ),
        body: Center(
          child: AlarmSetter(),
        ),
      ),
    );
  }
}

class AlarmSetter extends StatefulWidget {
  @override
  _AlarmSetterState createState() => _AlarmSetterState();
}

class _AlarmSetterState extends State<AlarmSetter> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _setAlarm() async {
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.SET_ALARM',
      arguments: {
        'android.intent.extra.alarm.HOUR': _selectedTime?.hour,
        'android.intent.extra.alarm.MINUTES': _selectedTime?.minute,
        'android.intent.extra.alarm.SKIP_UI': true,
        'android.intent.extra.alarm.MESSAGE': 'Alarm message here',
      },
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Set Alarm Time:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime!,
            );
            if (picked != null && picked != _selectedTime) {
              setState(() {
                _selectedTime = picked;
              });
            }
          },
          child: Text('Select Time'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _setAlarm();
          },
          child: Text('Set Alarm'),
        ),
      ],
    );
  }
}
