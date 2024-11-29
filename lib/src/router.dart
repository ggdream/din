import 'dart:async';

import 'context.dart';
import 'http_status_code.dart';

abstract class Router {
  Handler? notFoundHandler;

  void route(String method, String path, Handler handler);

  void notFound(Handler handler) {
    notFoundHandler = handler;
  }

  Handler? lookup(String method, String path);

  FutureOr<void> handle(Context ctx) async {
    final handler = lookup(ctx.request.method, ctx.request.uri.path);
    if (handler != null) {
      ctx.handlers.add(handler);
    } else {
      if (notFoundHandler != null) {
        ctx.handlers.add(notFoundHandler!);
      } else {
        ctx.handlers.add((Context ctx) {
          ctx.text("not found", status: HttpStatusCode.notFound);
        });
      }
    }

    await ctx.next();
  }
}

class MapRouter extends Router {
  final Map<String, Handler> _routes = {};

  @override
  void route(String method, String path, Handler handler) {
    _routes['$method-$path'] = handler;
  }

  @override
  Handler? lookup(String method, String path) {
    return _routes['$method-$path'];
  }
}
