import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/science_model.dart';
import 'package:ds/pages/director/system/inner/sciences/sciences_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class CUSciencePage extends StatelessWidget {
  final List<ScienceModel> sciences;
  final ScienceModel? science;
  const CUSciencePage({
    super.key,
    required this.sciences,
    this.science,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: ((context) => DSciencesVM(science)),
      child: Consumer<DSciencesVM>(
        builder: (context, DSciencesVM vm, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(science == null ? t.addScience : t.editScience),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              actions: science == null
                  ? null
                  : [
                      IconButton(
                        splashRadius: 25,
                        onPressed: (() {
                          vm.delete(sciences).then((value) {
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
                    children: [
                      TextFieldC(us: vm.name),
                      const SizedBox(height: 15),
                      TextFieldC(us: vm.des),
                      const SizedBox(height: 30),
                      ElevatedButtonC(
                        us: ButtonUS(
                          color: c.c6,
                          title: lan(science != null ? t.update : t.add),
                          onTap: (() {
                            vm.science != null
                                ? vm.update(sciences).then((value) {
                                    Navigator.pop(context);
                                  })
                                : vm.create(sciences).then((value) {
                                    Navigator.pop(context);
                                  });
                          }),
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
