import 'package:carpark_display/data/service/app_service.dart';
import 'package:carpark_display/presentation/page/entrance_page.dart';
import 'package:carpark_display/presentation/page/exit_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fontTextColor = TextEditingController();
  final backgroudTextColor = TextEditingController();
  final _appService = GetIt.I.get<AppService>();

  @override
  void initState() {
    super.initState();
    fontTextColor.text = _appService.fontText;
    backgroudTextColor.text = _appService.backgroundText;
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
            ElevatedButton(
                onPressed: openEntrancePage,
                child: const Text(
                  ' ทางเข้า ',
                  style: TextStyle(fontSize: 100.0),
                )),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
                onPressed: openExitPage,
                child: const Text(
                  ' ทางออก ',
                  style: TextStyle(fontSize: 100.0),
                )),
            const SizedBox(
              height: 50.0,
            ),
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
          ],
        ),
      ),
    );
  }

  openEntrancePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EntrancePage(),
      ),
    );
  }

  openExitPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ExitPage(),
      ),
    );
  }
}
