import 'dart:io';

String fixture(String path) => File('test/test_utils/fixtures/$path').readAsStringSync();
