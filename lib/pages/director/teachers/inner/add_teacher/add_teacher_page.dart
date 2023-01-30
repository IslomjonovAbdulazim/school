import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/pages/director/teachers/inner/add_teacher/add_teacher_vm.dart';
import 'package:ds/pages/director/teachers/view/token_item.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class AddTeacherPage extends StatelessWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddTeacherVM>(
      create: (_) => AddTeacherVM(),
      child: Consumer<AddTeacherVM>(
        builder: (context, AddTeacherVM vm, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.tokens),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  IgnorePointer(
                    ignoring: vm.isLoading,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      children: [
                        ...vm.tokens.map(
                          (token) => TokenItem(token: token),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButtonC(
                          us: ButtonUS(
                            color: c.c6,
                            title: lan(t.generateNewToken),
                            onTap: () {
                              vm.generateNewToken();
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
            ),
          );
        },
      ),
    );
  }
}
