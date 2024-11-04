import "package:dio/dio.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";

class ApiClient {

  // I like to keep the main client on its own, I would have a singleton to
  // manage the client and its configuration if we needed to store
  // authentication tokens or other data.

  // I would use flutter_secure_storage to store tokens securely.

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  )
    ..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: false,
        // requestBody: true,
        requestBody: false,
        responseBody: false,
        responseHeader: false,

        // error: true,
        error: true,
        // compact: true,
        enabled: true,
        maxWidth: 90,
      ),
    );

}