import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/pages/director/system/inner/call_schedule/call_schedule_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class AddCallSchedulePage extends StatelessWidget {
  const AddCallSchedulePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DCallScheduleVM>(
      create: (_) => DCallScheduleVM(false),
      child: Consumer<DCallScheduleVM>(
        builder: (context, DCallScheduleVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.addSchedule),
                style: s.t(
                  color: c.c1,
                  size: 17.5,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: Stack(
              children: [
                IgnorePointer(
                  ignoring: vm.isLoading,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            lan(t.startTime),
                            style: s.t(
                              color: c.c3,
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            onTimerDurationChanged: vm.initStart,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: c.c3),
                          ),
                          Text(
                            lan(t.endTime),
                            style: s.t(
                              color: c.c3,
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            onTimerDurationChanged: vm.initEnd,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Divider(color: c.c3),
                          ),
                          TextFieldC(us: vm.des),
                          const SizedBox(height: 30),
                          ElevatedButtonC(
                            us: ButtonUS(
                              color: c.c6,
                              title: lan(t.add),
                              onTap: () {
                                vm.update().then((value) {
                                  Navigator.pop(context, value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                vm.isLoading
                    ? Container(
                        height: size.height,
                        width: size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.3),
                        ),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(
                            color: c.c1,
                            strokeWidth: 7,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
