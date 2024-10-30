import 'package:carpark_display/domain/model/gate_log.dart';
import 'package:flutter/material.dart';

class EntranceDisplay extends StatelessWidget {
  const EntranceDisplay({super.key, required this.gateLog});

  final GateLog gateLog;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final double fontSize = height / 2;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ทางเข้า'),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.blue[300],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  gateLog.memberId == 0
                      ? "Visitor กรุณาลงทะเบียน"
                      : "Welcome ยินดีต้อนรับ",
                  style: TextStyle(fontSize: fontSize),
                )),
            Padding(
              padding: EdgeInsets.only(top: height / 4),
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    gateLog.plateNumber,
                    style: TextStyle(fontSize: fontSize),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
