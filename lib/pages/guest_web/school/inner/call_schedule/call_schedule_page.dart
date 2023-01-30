import 'package:ds/models/school_model.dart';

import '../../../../../utils/format.dart';
import 'call_schedule_vm.dart';
import 'view/add_call_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/lan.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class GWCallSchedulePage extends StatefulWidget {
  const GWCallSchedulePage({super.key});

  @override
  State<GWCallSchedulePage> createState() => _GCallSchedulePageState();
}

class _GCallSchedulePageState extends State<GWCallSchedulePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<GWCallScheduleVM>(
      create: (_) => GWCallScheduleVM(),
      child: Consumer<GWCallScheduleVM>(
        builder: (context, GWCallScheduleVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.schedule),
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
                    children: vm.schedules.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          e.des.isNotEmpty
                              ? Text(
                                  e.des,
                                  style: s.t(
                                    color: c.c3,
                                    size: 17,
                                    weight: FontWeight.w500,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Row(
                            children: [
                              Text(
                                format.formatTime2(e.startTime),
                                style: s.t(
                                  color: c.c3,
                                  size: 17.5,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' - ',
                                style: s.t(
                                  color: c.c3,
                                  size: 17.5,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                format.formatTime2(e.endTime),
                                style: s.t(
                                  color: c.c3,
                                  size: 17.5,
                                  weight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Divider(color: c.c3),
                        ],
                      );
                    }).toList(),
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
