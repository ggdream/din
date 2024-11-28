enum HttpStatusCode {
  // 2xx: 成功
  ok(200, 'OK'),
  created(201, 'Created'),
  accepted(202, 'Accepted'),
  nonAuthoritativeInformation(203, 'Non-Authoritative Information'),
  noContent(204, 'No Content'),
  resetContent(205, 'Reset Content'),
  partialContent(206, 'Partial Content'),

  // 3xx: 重定向
  movedPermanently(301, 'Moved Permanently'),
  found(302, 'Found'),
  seeOther(303, 'See Other'),
  notModified(304, 'Not Modified'),
  useProxy(305, 'Use Proxy'),
  temporaryRedirect(307, 'Temporary Redirect'),
  permanentRedirect(308, 'Permanent Redirect'),

  // 4xx: 客户端错误
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  paymentRequired(402, 'Payment Required'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  methodNotAllowed(405, 'Method Not Allowed'),
  notAcceptable(406, 'Not Acceptable'),
  proxyAuthenticationRequired(407, 'Proxy Authentication Required'),
  requestTimeout(408, 'Request Timeout'),
  conflict(409, 'Conflict'),
  gone(410, 'Gone'),
  lengthRequired(411, 'Length Required'),
  preconditionFailed(412, 'Precondition Failed'),
  payloadTooLarge(413, 'Payload Too Large'),
  uriTooLong(414, 'URI Too Long'),
  unsupportedMediaType(415, 'Unsupported Media Type'),
  rangeNotSatisfiable(416, 'Range Not Satisfiable'),
  expectationFailed(417, 'Expectation Failed'),
  iAmATeapot(418, "I'm a teapot"), // 这是一个愚蠢的状态码，源自一个愚弄标准

  // 5xx: 服务器错误
  internalServerError(500, 'Internal Server Error'),
  notImplemented(501, 'Not Implemented'),
  badGateway(502, 'Bad Gateway'),
  serviceUnavailable(503, 'Service Unavailable'),
  gatewayTimeout(504, 'Gateway Timeout'),
  httpVersionNotSupported(505, 'HTTP Version Not Supported'),
  variantAlsoNegotiates(506, 'Variant Also Negotiates'),
  insufficientStorage(507, 'Insufficient Storage'),
  loopDetected(508, 'Loop Detected'),
  notExtended(510, 'Not Extended'),
  networkAuthenticationRequired(511, 'Network Authentication Required');

  final int code;
  final String message;

  const HttpStatusCode(this.code, this.message);

  @override
  String toString() {
    return 'HTTP $code: $message';
  }
}
