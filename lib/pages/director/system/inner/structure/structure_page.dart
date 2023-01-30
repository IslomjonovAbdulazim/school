import 'package:ds/pages/director/system/inner/structure/structure_vm.dart';
import 'package:ds/utils/lan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles.dart';
import '../../../../../utils/titles.dart';

class DStructurePage extends StatelessWidget {
  const DStructurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DStructureVM>(
      create: ((context) => DStructureVM()),
      child: Consumer<DStructureVM>(
        builder: (context, DStructureVM vm, _) {
          return Scaffold(
            backgroundColor: c.c1,
            appBar: AppBar(
              backgroundColor: c.c3,
              title: Text(
                lan(t.structure),
                style: s.t(
                  color: c.c1,
                  weight: FontWeight.w700,
                  size: 20,
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              children: [
                Text(
                  lan(t.images),
                  style: s.t(
                    color: c.c3,
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                ),
                Divider(color: c.c3),
                Text(
                  lan(t.des),
                  style: s.t(
                    color: c.c3,
                    size: 15,
                    weight: FontWeight.w500,
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
