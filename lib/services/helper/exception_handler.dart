class ExceptionHandler implements Exception {
  final String? message;
  final int statusCode;
  String? returnMessage;

  ExceptionHandler({this.message = '', required this.statusCode});

  @override
  String toString() {
    statusCodeHandler();
    return returnMessage!;
  }

  void statusCodeHandler() {
    switch (statusCode) {
      case 400:
        returnMessage = message!.isNotEmpty ? message : "400 Bad Request";
        break;
      case 401:
        returnMessage =
            message!.isNotEmpty ? message : "401 UnAuthorized access";
        break;
      case 403:
        returnMessage =
            message!.isNotEmpty ? message : "403 Resource access forbidden";
        break;
      case 404:
        returnMessage =
            message!.isNotEmpty ? message : "404 Resource not Found";
        break;
      case 429:
        returnMessage = message!.isNotEmpty ? message : "429 Too many request";
        break;
      case 500:
        returnMessage =
            message!.isNotEmpty ? message : "500 Internal Server Error";
        break;
      case 502:
        returnMessage = message!.isNotEmpty ? message : "502 Bad Gateway";
        break;
      case 503:
        returnMessage =
            message!.isNotEmpty ? message : "503 Service Unavailable";
        break;
      case 504:
        returnMessage = message!.isNotEmpty
            ? message
            : "504 Error occured while Communication with Server";
        break;
      default:
        returnMessage = "Something Went Wrong";
        break;
    }
  }
}
