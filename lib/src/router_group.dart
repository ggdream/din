import 'context.dart';
import 'din_base.dart';

class RouterGroup {
  final String prefix;
  final List<Handler> middlewares = [];
  final RouterGroup? parent;
  late final Din engine;

  RouterGroup({
    required this.prefix,
    required this.parent,
    required this.engine,
  });

  RouterGroup.root()
      : prefix = '',
        parent = null;

  RouterGroup group(String prefix) {
    final newGroup = RouterGroup(
      prefix: this.prefix + prefix,
      parent: this,
      engine: engine,
    );

    engine.groups.add(newGroup);
    return newGroup;
  }

  RouterGroup use(Handler handler) {
    middlewares.add(handler);
    return this;
  }

  RouterGroup uses(List<Handler> handlers) {
    middlewares.addAll(handlers);
    return this;
  }

  RouterGroup route(String method, String path, Handler handler,
      [List<Handler>? middlewares]) {
    if (middlewares != null) {
      this.middlewares.addAll(middlewares);
    }

    final pattern = prefix + path;
    engine.router.route(method, pattern, handler);
    return this;
  }

  RouterGroup get(String path, Handler handler, [List<Handler>? middlewares]) {
    return route('GET', path, handler, middlewares);
  }

  RouterGroup post(String path, Handler handler, [List<Handler>? middlewares]) {
    return route('POST', path, handler, middlewares);
  }

  RouterGroup put(String path, Handler handler, [List<Handler>? middlewares]) {
    return route('PUT', path, handler, middlewares);
  }

  RouterGroup delete(String path, Handler handler,
      [List<Handler>? middlewares]) {
    return route('DELETE', path, handler, middlewares);
  }

  RouterGroup patch(String path, Handler handler,
      [List<Handler>? middlewares]) {
    return route('PATCH', path, handler, middlewares);
  }

  RouterGroup trace(String path, Handler handler,
      [List<Handler>? middlewares]) {
    return route('TRACE', path, handler, middlewares);
  }

  RouterGroup head(String path, Handler handler, [List<Handler>? middlewares]) {
    return route('HEAD', path, handler, middlewares);
  }
}
