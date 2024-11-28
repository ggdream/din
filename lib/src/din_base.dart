import 'dart:io';

import 'context.dart';
import 'router.dart';
import 'router_group.dart';

class Din extends RouterGroup {
  final router = Router();
  final List<RouterGroup> groups = [];

  Din() : super.root() {
    super.engine = this;
    groups.add(super.engine);
  }

  Future<void> run({
    dynamic host = "127.0.0.1",
    int port = 80,
  }) async {
    final server = await HttpServer.bind(host, port);
    await _serve(server);
  }

  Future<void> runTls({
    dynamic host = "127.0.0.1",
    int port = 443,
    required SecurityContext securityContext,
  }) async {
    final server = await HttpServer.bindSecure(
      host,
      port,
      securityContext,
    );
    await _serve(server);
  }

  Future<void> _serve(HttpServer server) async {
    await for (final request in server) {
      final handlers = <Handler>[];
      for (final group in groups) {
        if (request.uri.path.startsWith(group.prefix)) {
          handlers.addAll(group.middlewares);
        }
      }

      final ctx = Context.fromRequest(request: request, handlers: handlers);
      await router.handle(ctx);
      await request.response.close();
    }
  }
}
