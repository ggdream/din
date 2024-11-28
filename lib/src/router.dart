import 'dart:async';

import 'context.dart';
import 'http_status_code.dart';

class Router {
  final Map<String, Handler> _routes = {};

  void route(String method, String path, Handler handler) {
    _routes['$method-$path'] = handler;
  }

  Handler? lookup(String method, String path) {
    return _routes['$method-$path'];
  }

  FutureOr<void> handle(Context ctx) async {
    final handler = lookup(ctx.request.method, ctx.request.uri.path);
    if (handler != null) {
      ctx.handlers.add(handler);
    } else {
      ctx.handlers.add((Context ctx) {
        ctx.text("not found", status: HttpStatusCode.notFound);
      });
    }

    await ctx.next();
  }
}
