import 'package:ds/pages/director/system/system_vm.dart';
import 'package:ds/pages/director/system/view/system_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class DSystemPage extends StatelessWidget {
  const DSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DSystemVM>(
      create: ((context) => DSystemVM()),
      child: Consumer<DSystemVM>(
        builder: (context, DSystemVM vm, _) {
          return AnimationLimiter(
            child: vm.isGrid
                ? GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                      vm.items.length,
                      (int index) {
                        final us = vm.items[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: SystemItem1(
                                us: us,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : ListView.builder(
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
          );
        },
      ),
    );
  }
}
