import 'package:carpark_display/data/service/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final fontTextColor = TextEditingController();
  final backgroudTextColor = TextEditingController();

  final memberEntryText = TextEditingController();
  final visitorEntryText = TextEditingController();
  final overdueEntryText = TextEditingController();

  final memberExitText = TextEditingController();
  final visitorExitText = TextEditingController();
  final overdueExitText = TextEditingController();

  final _appService = GetIt.I.get<AppService>();

  @override
  void initState() {
    super.initState();
    fontTextColor.text = _appService.fontText;
    backgroudTextColor.text = _appService.backgroundText;

    memberEntryText.text = _appService.getEntryValue(memberType: 'resident');
    visitorEntryText.text = _appService.getEntryValue(memberType: 'visitor');
    overdueEntryText.text = _appService.getEntryValue(memberType: 'overdue');

    memberExitText.text = _appService.getExitValue(memberType: 'resident');
    visitorExitText.text = _appService.getExitValue(memberType: 'visitor');
    overdueExitText.text = _appService.getExitValue(memberType: 'overdue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Car Park Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: TextField(
                controller: fontTextColor,
                decoration: const InputDecoration(label: Text('Font Color')),
                onChanged: (value) => _appService.saveFontColor(value),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: TextField(
                controller: backgroudTextColor,
                decoration:
                    const InputDecoration(label: Text('Backgroud Color')),
                onChanged: (value) => _appService.saveBackgroundColor(value),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'ข้อความทางเข้า',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: memberEntryText,
                        decoration:
                            const InputDecoration(label: Text('สมาชิก')),
                        onChanged: (value) => _appService.saveEntryValue(
                            memberType: 'resident', value: value),
                      ),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: visitorEntryText,
                        decoration:
                            const InputDecoration(label: Text('ผู้ติดต่อ')),
                        onChanged: (value) => _appService.saveEntryValue(
                            memberType: 'visitor', value: value),
                      ),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: overdueEntryText,
                        decoration: const InputDecoration(
                            label: Text('ค้างค่าส่วนกลาง')),
                        onChanged: (value) => _appService.saveEntryValue(
                            memberType: 'overdue', value: value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    const Text(
                      'ข้อความทางออก',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: memberExitText,
                        decoration:
                            const InputDecoration(label: Text('สมาชิก')),
                        onChanged: (value) => _appService.saveExitValue(
                            memberType: 'resident', value: value),
                      ),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: visitorExitText,
                        decoration:
                            const InputDecoration(label: Text('ผู้ติดต่อ')),
                        onChanged: (value) => _appService.saveExitValue(
                            memberType: 'visitor', value: value),
                      ),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextField(
                        controller: overdueExitText,
                        decoration: const InputDecoration(
                            label: Text('ค้างค่าส่วนกลาง')),
                        onChanged: (value) => _appService.saveExitValue(
                            memberType: 'overdue', value: value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: saveAndExit,
              child: const Text(
                ' บันทึก ',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveAndExit() {
    Navigator.of(context).pop();
  }
}
