import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/custom/elevated_button_c.dart';
import 'package:ds/pages/director/account/account_vm.dart';
import 'package:ds/pages/log_in/log_in_page.dart';
import 'package:ds/us/button_us.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/fb_auth_service.dart';
import '../../../services/fb_firestore_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/format.dart';
import '../../../utils/hints.dart';
import '../../../utils/styles.dart';
import '../../../utils/titles.dart';
import '../../teacher/account/innner/lan/lan_page.dart';

class DAccountPage extends StatelessWidget {
  const DAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<DAccountVM>(
      create: ((context) => DAccountVM()),
      child: Consumer<DAccountVM>(
        builder: (context, DAccountVM vm, _) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: vm.isLoading,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            color: c.c2,
                            shape: BoxShape.circle,
                            image: vm.selectedImage != null ||
                                    (vm.director != null &&
                                        vm.director?.detail.avatar != null)
                                ? DecorationImage(
                                    image: vm.selectedImage != null
                                        ? FileImage(
                                            File(vm.selectedImage!.path),
                                          )
                                        : CachedNetworkImageProvider(
                                            vm.director!.detail.avatar!.path,
                                          ) as ImageProvider,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: IconButton(
                            onPressed: () {
                              vm.pickImage();
                            },
                            splashRadius: 25,
                            icon: Icon(
                              Icons.image,
                              color: c.c3,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: c.c3),
                    ListTile(
                      title: Text(
                        '${lan(t.language)} - ${lan(currLan)}',
                        style: s.t(
                          size: 20,
                          weight: FontWeight.w600,
                          color: c.c3,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TLanPage(),
                            ),
                          ).then((value) {
                            if (value != null) {
                              vm.nf();
                            }
                          });
                        },
                        splashRadius: 30,
                        icon: Icon(
                          CupertinoIcons.chevron_right,
                          color: c.c3,
                          size: 30,
                        ),
                      ),
                    ),
                    Divider(color: c.c3),
                    const SizedBox(height: 20),
                    Text(
                      lan(t.fullname),
                      style: s.t(
                        color: c.c3,
                        size: 15,
                        weight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      autocorrect: false,
                      style: s.t(
                        size: 20,
                        weight: FontWeight.w600,
                        color: c.c3,
                      ),
                      controller: vm.name,
                      onSaved: (a) {},
                      cursorColor: c.c3,
                      decoration: InputDecoration(
                        hintText: lan(h.name),
                        hintStyle: s.t(
                          size: 17.5,
                          weight: FontWeight.w300,
                          color: c.c3,
                        ),
                        filled: true,
                        fillColor: c.c1,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ), // todo name
                    Divider(color: c.c3),
                    Text(
                      lan(t.bio),
                      style: s.t(
                        color: c.c3,
                        size: 15,
                        weight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      autocorrect: false,
                      style: s.t(
                        size: 20,
                        weight: FontWeight.w600,
                        color: c.c3,
                      ),
                      controller: vm.bio,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onSaved: (a) {},
                      cursorColor: c.c3,
                      decoration: InputDecoration(
                        hintText: lan(h.bio),
                        hintStyle: s.t(
                          size: 17.5,
                          weight: FontWeight.w300,
                          color: c.c3,
                        ),
                        filled: true,
                        fillColor: c.c1,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ), // todo name
                    Divider(color: c.c3),
                    Text(
                      lan(t.tels),
                      style: s.t(
                        color: c.c3,
                        size: 15,
                        weight: FontWeight.w500,
                      ),
                    ),
                    ...vm.tel.map(
                      (e) => Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autocorrect: false,
                              cursorColor: c.c3,
                              controller: e,
                              style: s.t(
                                color: c.c3,
                                weight: FontWeight.w500,
                                size: 20,
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                format.uz(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: lan(h.phoneNumber),
                                hintStyle: s.t(
                                  color: c.c3,
                                  size: 17,
                                  weight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            splashRadius: 25,
                            onPressed: () {
                              vm.deleteTel(e);
                            },
                            icon: Icon(
                              CupertinoIcons.delete,
                              color: c.c8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          backgroundColor: c.c3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: vm.addTel,
                        child: Text(
                          lan(t.add),
                        ),
                      ),
                    ),
                    Divider(color: c.c3),
                    const SizedBox(height: 40),
                    ElevatedButtonC(
                      us: ButtonUS(
                        title: lan(t.save),
                        onTap: () {
                          vm.save();
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                    ElevatedButtonC(
                      us: ButtonUS(
                        title: lan(t.signOut),
                        color: c.c8,
                        onTap: () {
                          auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LogInPage(),
                            ),
                          );
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
          );
        },
      ),
    );
  }
}
