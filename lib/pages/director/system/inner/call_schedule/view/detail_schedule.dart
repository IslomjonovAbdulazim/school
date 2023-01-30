import 'package:ds/models/school_model.dart';
import 'package:ds/pages/director/system/inner/call_schedule/view/add_schedules_vm.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../custom/elevated_button_c.dart';
import '../../../../../../custom/text_field_c.dart';
import '../../../../../../us/button_us.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class DetailSchedulePage extends StatelessWidget {
  final ScheduleModel schedule;
  final ScheduleClassModel schedules;
  final int day;

  const DetailSchedulePage({
    Key? key,
    required this.schedule,
    required this.day,
    required this.schedules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SchedulesAddVM>(
      create: (BuildContext context) => SchedulesAddVM(schedule),
      child: Consumer<SchedulesAddVM>(
        builder: (context, SchedulesAddVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.editSchedule),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    vm.deleteSchedule(schedules, schedule, day).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: c.c8,
                    size: 30,
                  ),
                ),
              ],
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
                          title: lan(t.update),
                          onTap: () {
                            vm.updateSchedule(schedules, day).then((value) {
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
