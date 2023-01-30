import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/custom/text_field_c.dart';
import 'package:ds/models/science_model.dart';
import 'package:ds/pages/log_in/log_in_vm.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/hints.dart';
import '../../utils/styles.dart';
import '../../utils/titles.dart';

class SignUpAsTeacherPage extends StatelessWidget {
  final String code;

  const SignUpAsTeacherPage({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogInVM>(
      create: (_) => LogInVM(context),
      child: Consumer<LogInVM>(
        builder: (context, LogInVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.logInAsTeacher),
                style: s.t(
                  color: c.c1,
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: Form(
              key: vm.keyTeacherUp,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                children: [
                  ...vm.signUpTeacher.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        autocorrect: false,
                        style: s.t(
                          size: d.t3,
                          weight: FontWeight.w600,
                        ),
                        controller: e.controller,
                        onSaved: (a) {
                          if (vm.keyTeacherUp.currentState?.validate() ==
                              true) {
                            vm.keyTeacherUp.currentState?.save();
                          }
                        },
                        cursorColor: c.c1,
                        decoration: InputDecoration(
                          hintText: lan(e.title),
                          errorText: vm.errorsTeacherUp[e.title] == null
                              ? null
                              : lan(vm.errorsTeacherUp[e.title]!),
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
                    );
                  }),
                  Divider(color: c.c3),
                  vm.errorsTeacherUp[h.science] != null
                      ? Text(
                          lan(vm.errorsTeacherUp[h.science]!),
                          style: s.t(
                            color: c.c8,
                            size: 15,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Autocomplete<String>(
                    optionsMaxHeight: 400,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return vm.sciences.map((e) => e.name);
                      }
                      List<ScienceModel> options = vm.sciences
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                          .toList();
                      return options.map((e) => e.name);
                    },
                    onSelected: (String selection) {
                      ScienceModel id = vm.sciences
                          .firstWhere((element) => element.name == selection);
                      vm.science = id.id;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButtonC(
                    us: ButtonUS(
                      color: c.c6,
                      title: lan(t.signUp),
                      onTap: () {
                        vm.signUpTeacherFunc(code);
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

class SignUpAsDirectorPage extends StatelessWidget {
  const SignUpAsDirectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogInVM>(
      create: (_) => LogInVM(context),
      child: Consumer<LogInVM>(
        builder: (context, LogInVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.loginAsDirector),
                style: s.t(
                  color: c.c1,
                  size: 17.5,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 15,
              ),
              children: [
                ...vm.signUpDirector.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFieldC(us: e),
                  );
                }),
                const SizedBox(height: 15),
                ElevatedButtonC(
                  us: ButtonUS(
                    title: lan(t.signUp),
                    color: c.c6,
                    onTap: () async {
                      await vm.signUpDirectorFunc();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
