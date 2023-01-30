import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/pages/director/system/inner/call_schedule/view/add_schedules_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class AddClassSchedulePage extends StatelessWidget {
  const AddClassSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SchedulesAddVM>(
      create: (BuildContext context) => SchedulesAddVM(),
      child: Consumer<SchedulesAddVM>(
        builder: (context, SchedulesAddVM vm, _) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: vm.isLoading,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: c.c1,
                  appBar: AppBar(
                    backgroundColor: c.c3,
                    title: Text(
                      lan(t.addClass),
                      style: s.t(
                        color: c.c1,
                        size: 20,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldC(
                          us: vm.classTeacher,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFieldC(
                            us: vm.grade,
                          ),
                        ),
                        TextFieldC(
                          us: vm.des,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                          ),
                          child: ElevatedButtonC(
                            us: ButtonUS(
                              title: lan(t.add),
                              color: c.c6,
                              onTap: () {
                                vm.addClassSchedule().then((value) {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
          );
        },
      ),
    );
  }
}
