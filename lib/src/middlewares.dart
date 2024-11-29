import 'context.dart';
import 'logger.dart';

Handler recovery({
  Logger? logger,
}) {
  logger ??= DefaultLogger();

  return (Context ctx) async {
    try {
      await ctx.next();
    } catch (error, stackTrace) {
      logger!.log(
        Level.error,
        "din recovery",
        error: error,
        stackTrace: stackTrace,
      );
    }
  };
}

Handler cors() {
  return (Context ctx) async {
    ctx.response.headers.add("Access-Control-Allow-Origin", "*");
    ctx.response.headers.add("Access-Control-Allow-Methods", "*");
    ctx.response.headers.add("Access-Control-Allow-Headers", "*");
    await ctx.next();
  };
}

Handler logger({
  Logger? logger,
}) {
  logger ??= DefaultLogger();

  return (Context ctx) async {
    final start = DateTime.now();
    await ctx.next();
    final cost = DateTime.now().difference(start).inMilliseconds;
    logger!.log(
      Level.info,
      "${ctx.request.method} ${ctx.request.uri.path} ${ctx.response.statusCode} ${cost}ms",
    );
  };
}
