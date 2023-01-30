import 'package:ds/pages/teacher/system/system_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../director/system/view/system_item.dart';

class TSystemPage extends StatelessWidget {
  const TSystemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<TSystemVM>(
      create: ((context) => TSystemVM()),
      child: Consumer<TSystemVM>(
        builder: (context, TSystemVM vm, _) {
          return Stack(
            children: [
              IgnorePointer(
                ignoring: vm.isLoading,
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    itemCount: vm.items.length,
                    itemBuilder: ((context, index) {
                      final us = vm.items[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: SystemItem2(us: us),
                          ),
                        ),
                      );
                    }),
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
          );
        },
      ),
    );
  }
}
