import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/pages/director/system/inner/reception_time/reception_time_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../models/school_model.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class AddReceptionTimePage extends StatelessWidget {
  final List<ReceptionTimeModel> data;
  final ReceptionTimeModel? info;

  const AddReceptionTimePage({
    Key? key,
    required this.data,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DReceptionTimeVM>(
      create: (_) => DReceptionTimeVM(
        i: false,
        data: data,
        reception: info,
      ),
      child: Consumer<DReceptionTimeVM>(
        builder: (context, DReceptionTimeVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.addReceptionTime),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    vm.delete().then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  splashRadius: 25,
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: c.c8,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vm.errors[t.days] != null
                                  ? vm.errors[t.days]!
                                  : lan(t.days),
                              style: s.t(
                                color: vm.errors[t.days] == null ? c.c3 : c.c8,
                                weight: FontWeight.w700,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(
                            t.shortDays.length,
                            (index) {
                              final e = t.shortDays[index];
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    vm.selectDay(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: vm.selectedDays.contains(index)
                                            ? c.c3
                                            : c.c2,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Text(
                                        e,
                                        style: s.t(
                                          size: 16,
                                          weight: FontWeight.w500,
                                          color: vm.selectedDays.contains(index)
                                              ? c.c1
                                              : c.c3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Divider(color: c.c3),
                        ),
                        TextFieldC(us: vm.des),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Divider(color: c.c3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vm.errors[t.startTime] != null
                                  ? vm.errors[t.startTime]!
                                  : lan(t.startTime),
                              style: s.t(
                                color: vm.errors[t.startTime] != null
                                    ? c.c8
                                    : c.c3,
                                size: 20,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vm.errors[t.endTime] != null
                                  ? vm.errors[t.endTime]!
                                  : lan(t.endTime),
                              style: s.t(
                                color:
                                    vm.errors[t.endTime] != null ? c.c8 : c.c3,
                                size: 20,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
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
                            title: lan(info != null ? t.update : t.add),
                            onTap: () {
                              if (info == null) {
                                vm.create().then((value) {
                                  if (value) {
                                    Navigator.pop(context, vm.toCreate);
                                  }
                                });
                              } else {
                                vm.updateReceptionTime().then((value) {
                                  if (value) {
                                    Navigator.pop(context, vm.toCreate);
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 200),
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
            ),
          );
        },
      ),
    );
  }
}
