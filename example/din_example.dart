import 'dart:async';

import 'package:din/din.dart';

Future<void> main(List<String> arguments) async {
  try {
    final din = Din()
      ..use(recovery())
      ..use(logger());
    din.notFound((Context ctx) {
      ctx.text('oh! not found');
    });
    din.get('/hello', (Context ctx) {
      ctx.text("hello");
    });

    await din.run(port: 8080);
  } catch (e) {
    print("Error occurred: $e");
  }
}
