import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'http_status_code.dart';

typedef Handler = FutureOr<void> Function(Context context);

class Context {
  final HttpRequest request;

  int _index = -1;
  final List<Handler> handlers;

  Context.fromRequest({
    required this.request,
    required this.handlers,
  });

  FutureOr<void> next() async {
    _index++;
    for (; _index < handlers.length; _index++) {
      await handlers[_index](this);
    }
  }

  void status(HttpStatusCode status) {
    request.response.statusCode = status.code;
  }

  void contentType(String type) {
    request.response.headers.contentType = ContentType.parse(type);
  }

  HttpHeaders headers() {
    return request.response.headers;
  }

  void model(dynamic data,
      {HttpStatusCode status = HttpStatusCode.ok, String? charset}) async {
    final value = jsonEncode(data);
    request.response
      ..statusCode = status.code
      ..headers.contentType =
          ContentType("application", "json", charset: charset)
      ..write(value);
  }

  void html(String data,
      {HttpStatusCode status = HttpStatusCode.ok, String? charset}) async {
    request.response
      ..statusCode = status.code
      ..headers.contentType = ContentType("text", "html", charset: charset)
      ..write(data);
  }

  void text(String data,
      {HttpStatusCode status = HttpStatusCode.ok, String? charset}) async {
    request.response
      ..statusCode = status.code
      ..headers.contentType = ContentType("text", "plain", charset: charset)
      ..write(data);
  }

  void json(Map<String, dynamic> data,
      {HttpStatusCode status = HttpStatusCode.ok, String? charset}) async {
    request.response
      ..statusCode = status.code
      ..headers.contentType =
          ContentType("application", "json", charset: charset)
      ..write(jsonEncode(data));
  }

  void bytes(List<int> data,
      {HttpStatusCode status = HttpStatusCode.ok, String? charset}) async {
    request.response
      ..statusCode = status.code
      ..headers.contentType =
          ContentType("application", "octet-stream", charset: charset)
      ..add(data);
  }

  Future<void> stream(Stream<List<int>> data,
      {HttpStatusCode status = HttpStatusCode.ok}) async {
    request.response.statusCode = status.code;
    await request.response.addStream(data);
  }

  Future<void> close() async {
    await request.response.close();
  }
}
