import 'package:ds/models/school_model.dart';
import 'package:ds/services/fb_firestore_service.dart';
import 'package:ds/us/text_field_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:ds/utils/lan/en.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../utils/hints.dart';
import '../../../../../../utils/titles.dart';

class SchedulesAddVM extends ChangeNotifier {
  bool isLoading = false;
  String? day;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  TextFieldUS grade = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.classGrade),
  );
  TextFieldUS classTeacher = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.classTeacher),
  );
  TextFieldUS teacher = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.teacher),
  );
  TextFieldUS science = TextFieldUS(
    controller: TextEditingController(),
    title: lan(h.science),
  );
  TextFieldUS des = TextFieldUS(
    isMultiline: true,
    controller: TextEditingController(),
    title: lan(h.des),
  );
  DateTime? time;

  SchedulesAddVM([ScheduleModel? schedule]) {
    init(schedule);
  }

  void init(ScheduleModel? schedule) {
    time = schedule?.time;
    science = TextFieldUS(
      controller: TextEditingController(text: schedule?.science),
      title: lan(h.science),
    );
    teacher = TextFieldUS(
      controller: TextEditingController(text: schedule?.teacher),
      title: lan(h.teacher),
    );
    start = schedule?.startTime ?? DateTime.now();
    end = schedule?.endTime ?? DateTime.now();
  }

  Future<void> addClassSchedule() async {
    _update();
    var schedule = ScheduleClassModel(
      time: DateTime.now(),
      id: 'id',
      des: des.controller.text,
      classTeacher: classTeacher.controller.text,
      grade: grade.controller.text,
      schedules: List.generate(
        7,
        (index) => ScheduleDailyModel(
          day: index,
          schedules: [],
          // overallEnd: overallEnd,
          // overallStart: overallStart,
        ),
      ),
    );
    await fb.addClass(schedule);
    _update();
  }

  Future<void> deleteSchedule(
    ScheduleClassModel classSchedule,
    ScheduleModel schedule,
    int day,
  ) async {
    _update();
    classSchedule.schedules[day].schedules.removeWhere(
      (element) => element.time == schedule.time,
    );
    fb.updateClass(classSchedule);
    _update();

  }

  Future<void> deleteClassSchedule(ScheduleClassModel schedule) async {
    _update();
    await fb.delete(schedule);
    _update();
  }

  void _update() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void selectDay(String day) {
    this.day = day;
    notifyListeners();
  }

  Future<void> updateSchedule(
    ScheduleClassModel data,
    int day,
  ) async {
    _update();
    ScheduleModel schedule = ScheduleModel(
      endTime: end,
      teacher: teacher.controller.text,
      science: science.controller.text,
      startTime: start,
      time: time ?? DateTime.now(),
    );
    late int index;
    print(day);
    print(data.schedules);
    for (int i = 0; i < data.schedules[day].schedules.length; i++) {
      if (data.schedules[day].schedules[i].time == schedule.time) {
        index = i;
      }
    }
    data.schedules[day].schedules[index] = schedule;
    await fb.updateClass(data);
    _update();
  }

  void nf() {
    notifyListeners();
  }

  Future<void> addSchedule(
    ScheduleClassModel data,
    int day,
  ) async {
    _update();
    ScheduleModel schedule = ScheduleModel(
      endTime: end,
      teacher: teacher.controller.text,
      science: science.controller.text,
      startTime: start,
      time: DateTime.now(),
    );
    data.schedules[day].schedules.add(schedule);
    await fb.updateClass(data);
    _update();
  }

  void initStart(Duration val) {
    start = DateTime(2023, 1, 1, val.inHours, val.inMinutes % 60);
    notifyListeners();
  }

  void initEnd(Duration val) {
    end = DateTime(2023, 1, 1, val.inHours, val.inMinutes % 60);
    notifyListeners();
  }
}
