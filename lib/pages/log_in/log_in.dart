import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/pages/director/bnb/bnb_page.dart';
import 'package:ds/pages/log_in/log_in_vm.dart';
import 'package:ds/pages/teacher/bnb/bnb_page.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/hints.dart';
import '../../utils/styles.dart';
import '../../utils/titles.dart';

class LogIn extends StatelessWidget {
  final String title;

  const LogIn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LogInVM>(
      create: (_) => LogInVM(context),
      child: Consumer<LogInVM>(
        builder: (context, LogInVM vm, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(title),
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
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: vm.key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            autocorrect: false,
                            style: s.t(
                              size: d.t3,
                              weight: FontWeight.w600,
                            ),
                            controller: vm.nick.controller,
                            onSaved: (a) {
                              if (vm.key.currentState?.validate() == true) {
                                vm.key.currentState?.save();
                              }
                            },
                            cursorColor: c.c1,
                            decoration: InputDecoration(
                              hintText: vm.nick.title,
                              errorText: vm.loginErrors[h.nick],
                              hintStyle: s.t(
                                size: d.t2,
                                weight: FontWeight.w300,
                              ),
                              filled: true,
                              fillColor: c.c3,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            style: s.t(
                              size: d.t3,
                              weight: FontWeight.w600,
                            ),
                            controller: vm.password.controller,
                            onSaved: (a) {
                              if (vm.key.currentState?.validate() == true) {
                                vm.key.currentState?.save();
                              }
                            },
                            cursorColor: c.c1,
                            decoration: InputDecoration(
                              hintText: vm.password.title,
                              errorText: vm.loginErrors[h.password],
                              hintStyle: s.t(
                                size: d.t2,
                                weight: FontWeight.w300,
                              ),
                              filled: true,
                              fillColor: c.c3,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButtonC(
                            us: ButtonUS(
                              color: c.c6,
                              title: lan(t.signIn),
                              onTap: () {
                                vm.logIn(title).then((value) {
                                  if (value) {
                                    Navigator.popUntil(context, (route) => route.isFirst);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            title == t.loginAsDirector
                                                ? const DBNBPage()
                                                : const TBNBPage(),
                                      ),
                                    );
                                  }
                                });
                              },
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
            ),
          );
        },
      ),
    );
  }
}
