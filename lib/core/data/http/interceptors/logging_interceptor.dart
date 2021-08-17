// ignore_for_file: avoid_print
import 'dart:convert';

import '../../../exports/app_dependencies.dart';

InterceptorsWrapper logginInterceptor() {
  return InterceptorsWrapper(
    onResponse: (response, handler) {
      print('\n================================= Start of response data =========== ======================');
      print('data = ${const JsonEncoder.withIndent('  ').convert(response.data)}');
      print('================================= End of response data ============= ====================\n');
    },
  );
}
