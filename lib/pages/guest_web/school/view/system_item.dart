import 'package:ds/us/item_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class SystemItem1 extends StatelessWidget {
  final ItemUS us;
  const SystemItem1({super.key, required this.us});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          splashColor: c.c3.withOpacity(.5),
          highlightColor: c.c3.withOpacity(.3),
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => us.page),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.c3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: us.title
                  .split(' ')
                  .map((e) => Text("$e ",
                      style: s.t(
                        color: c.c1,
                        weight: FontWeight.w800,
                        size: 25,
                      )))
                  .toList(),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: Align(
        //     alignment: Alignment.topRight,
        //     child: IconButton(
        //       splashRadius: 25,
        //       onPressed: () {},
        //       icon: Icon(
        //         CupertinoIcons.info,
        //         color: c.c1,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class SystemItem2 extends StatelessWidget {
  final ItemUS us;
  const SystemItem2({super.key, required this.us});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: c.c3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => us.page),
            ),
          );
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          us.title,
          style: s.t(
            color: c.c1,
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_right,
          color: c.c1,
          // size: 27,
        ),
      ),
    );
  }
}
