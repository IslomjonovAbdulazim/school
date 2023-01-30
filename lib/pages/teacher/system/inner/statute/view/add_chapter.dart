import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/statutes_model.dart';
import 'package:ds/pages/director/system/inner/statute/statute_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../../utils/titles.dart';

class AddChapter extends StatelessWidget {
  final StatuteModel? statute;
  final List<StatuteModel> statutes;
  const AddChapter({
    super.key,
    this.statute,
    required this.statutes,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DStatuteVM>(
      create: (context) => DStatuteVM(null, statute),
      child: Consumer<DStatuteVM>(
        builder: (context, DStatuteVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(statute == null ? t.addChapter : t.editChapter),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: statute == null
                  ? null
                  : [
                      IconButton(
                        splashRadius: 25,
                        onPressed: (() {
                          vm.deleteChapter(statutes, statute!).then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        }),
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: c.c8,
                          size: 27,
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
                      TextFieldC(us: vm.chapter),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          color: c.c6,
                          title: lan(statute != null ? t.update : t.add),
                          onTap: () {
                            statute == null
                                ? vm.createChapter(statutes).then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  })
                                : vm.updateChapter(statute!).then((value) {
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
