import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/pages/log_in/log_in.dart';
import 'package:ds/pages/log_in/sign_up.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';
import '../../utils/titles.dart';
import 'log_in_vm.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LogInVM>(
      create: (_) => LogInVM(context),
      child: Consumer<LogInVM>(
        builder: (context, LogInVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.login),
                style: s.t(
                  color: c.c1,
                  weight: FontWeight.w700,
                  size: 20,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonC(
                    us: ButtonUS(
                      title: lan(t.loginAsDirector),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LogIn(
                              title: t.loginAsDirector,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButtonC(
                    us: ButtonUS(
                      title: lan(t.logInAsTeacher),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LogIn(
                              title: t.logInAsTeacher,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButtonC(
                    us: ButtonUS(
                      title: lan(t.signUp),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUp(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
