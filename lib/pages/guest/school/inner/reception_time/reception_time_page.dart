import '../../../../director/system/inner/reception_time/reception_time_vm.dart';
import 'package:ds/utils/format.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class GReceptionTimePage extends StatelessWidget {
  const GReceptionTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DReceptionTimeVM>(
      create: ((context) => DReceptionTimeVM()),
      child: Consumer<DReceptionTimeVM>(
        builder: (context, DReceptionTimeVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.receptionTime),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  itemCount: vm.data.length,
                  itemBuilder: (_, int index) {
                    final d = vm.data[index];
                    return Card(
                      color: c.c2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              d.des,
                              style: s.t(
                                color: c.c3,
                                size: 18,
                                weight: FontWeight.w700,
                              ),
                            ),
                            Divider(color: c.c3),
                            Text(
                              '${format.formatTime(d.start)} - ${format.formatTime(d.end)}',
                              style: s.t(
                                color: c.c3,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Divider(color: c.c3),
                            Row(
                              children: d.days.map((e) {
                                return Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Text(
                                    '${t.shortDays[e]},',
                                    style: s.t(
                                      color: c.c3,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
