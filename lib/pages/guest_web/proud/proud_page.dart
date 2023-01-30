import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds/pages/guest/proud/proud_vm.dart';
import 'package:ds/pages/guest_web/proud/proud_vm.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/pride_model.dart';
import '../../../services/fb_firestore_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/format.dart';
import '../../../utils/styles.dart';
import '../../director/pride/inner/add_pride/edit_pride_page.dart';

class GWProudPage extends StatelessWidget {
  const GWProudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GWProudVM(),
      child: Consumer<GWProudVM>(
        builder: (context, GWProudVM vm, _) {
          return FirestoreListView<PrideModel>(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            pageSize: 3,
            query: fb.prides(),
            itemBuilder: ((context, doc) {
              _AppValueNotifier appValueNotifier = _AppValueNotifier();
              final PrideModel pride = doc.data();
              return ValueListenableBuilder(
                valueListenable: appValueNotifier.valueNotifier,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: c.c2,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: c.c5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: pride.maxRatio,
                            child: PageView(
                              physics: const BouncingScrollPhysics(),
                              controller: PageController(),
                              onPageChanged: appValueNotifier.incrementNotifier,
                              children: pride.media.map(
                                    (e) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(e.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pride.media.length,
                                  (index) => Padding(
                                padding: const EdgeInsets.all(2),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: value == index ? 30 : 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: c.c3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            pride.fullname,
                            style: s.t(
                              color: c.c3,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            pride.why,
                            style: s.t(
                              color: c.c3,
                              size: 15,
                              weight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            format.all(pride.time),
                            style: s.t(
                              color: c.c3,
                              size: 15,
                              weight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}

class _AppValueNotifier {
  ValueNotifier valueNotifier = ValueNotifier(0);

  void incrementNotifier(int index) {
    valueNotifier.value = index;
  }
}
