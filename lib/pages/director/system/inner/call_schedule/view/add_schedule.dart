import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/school_model.dart';
import 'package:ds/pages/director/system/inner/call_schedule/view/add_schedules_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/lan.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class AddSchedulePage extends StatelessWidget {
  final ScheduleClassModel schedule;
  final int day;

  const AddSchedulePage({
    Key? key,
    required this.schedule,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SchedulesAddVM>(
      create: (BuildContext context) => SchedulesAddVM(),
      child: Consumer<SchedulesAddVM>(
        builder: (context, SchedulesAddVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.addSchedule),
                style: s.t(
                  color: c.c1,
                  size: 20,
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
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TextFieldC(us: vm.science),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFieldC(us: vm.teacher),
                      ),
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
                        initialTimerDuration: vm.start != null
                            ? Duration(
                                hours: vm.start!.hour,
                                minutes: vm.start!.minute,
                              )
                            : Duration.zero,
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: vm.initStart,
                      ),
                      Divider(color: c.c3),
                      const SizedBox(height: 10),
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
                        initialTimerDuration: vm.end != null
                            ? Duration(
                                hours: vm.end!.hour,
                                minutes: vm.end!.minute,
                              )
                            : Duration.zero,
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: vm.initEnd,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          color: c.c6,
                          title: lan(t.add),
                          onTap: () {
                            vm.addSchedule(schedule, day).then((value) {
                              Navigator.pop(context);
                            });
                          },
                        ),
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
