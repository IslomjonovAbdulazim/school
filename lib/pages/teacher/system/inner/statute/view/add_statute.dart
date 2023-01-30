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

class AddStatute extends StatelessWidget {
  final StatuteModel statute;
  final String? title;
  const AddStatute({
    super.key,
    required this.statute,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DStatuteVM>(
      create: ((context) => DStatuteVM(title)),
      child: Consumer<DStatuteVM>(
        builder: (context, DStatuteVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(title == null ? t.addStatute : t.editStatute),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: title != null
                  ? [
                      IconButton(
                        onPressed: (() {
                          vm.deleteStatute(statute).then((value) {
                            Navigator.pop(context);
                          });
                        }),
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: c.c8,
                        ),
                      )
                    ]
                  : null,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 5,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TextFieldC(us: vm.statute),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          title: lan(title == null ? t.add : t.update),
                          color: c.c6,
                          onTap: () async {
                            title == null
                                ? vm.createStatute(statute).then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  })
                                : vm.updateStatute(statute).then((value) {
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
