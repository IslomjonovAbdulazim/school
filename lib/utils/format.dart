import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final format = Format.instance;

class Format {
  Format._();

  static Format instance = Format._();

  String formatTime(DateTime t) => DateFormat.jm().format(t);

  String formatTime2(DateTime t) => DateFormat.Hm().format(t);

  String formatDate(DateTime t) => DateFormat.yMd().format(t);

  String all(DateTime t) => DateFormat('dd-MM-yyyy').format(t);

  MaskTextInputFormatter uz() => MaskTextInputFormatter(
        mask: '+(998) ## ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
}
