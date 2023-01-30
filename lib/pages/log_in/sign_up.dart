import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';
import '../../utils/titles.dart';
import 'log_in_vm.dart';
class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
            body: Stack(
              children: [
                IgnorePointer(
                  ignoring: vm.isLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
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
                            controller: vm.token!.controller,
                            onSaved: (a) {
                              if (vm.key.currentState?.validate() == true) {
                                vm.key.currentState?.save();
                              }
                            },
                            cursorColor: c.c1,
                            decoration: InputDecoration(
                              hintText: vm.token!.title,
                              errorText: vm.error == null ? null : lan(vm.error!),
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
                          const SizedBox(height: 20),
                          ElevatedButtonC(
                            us: vm.checkToken!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                vm.isLoading? Container(
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
                ): const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
