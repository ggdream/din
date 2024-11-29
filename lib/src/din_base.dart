import 'dart:io';

import 'context.dart';
import 'logger.dart';
import 'router.dart';
import 'router_group.dart';

class Din extends RouterGroup {
  final Router router;
  final Logger logger;
  final List<RouterGroup> groups = [];

  Din({
    Router? router,
    Logger? logger,
  })  : logger = logger ?? DefaultLogger(),
        router = router ?? MapRouter(),
        super.root() {
    super.engine = this;
    groups.add(super.engine);
  }

  void notFound(Handler handler) {
    router.notFound(handler);
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
      _handle(request);
    }
  }

  Future<void> _handle(HttpRequest request) async {
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
