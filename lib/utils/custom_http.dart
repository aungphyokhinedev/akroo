import 'package:http_middleware/http_middleware.dart';
class CustomHttp
{
  static String accessToken;
  static HttpWithMiddleware http =  HttpWithMiddleware.build(middlewares: [
   // Logger(),
    AddBarrier()
    ]);
  

}

class Logger extends MiddlewareContract {
  @override
  interceptRequest({RequestData data}) {
    print("Method: ${data.method}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
  }

  @override
  interceptResponse({ResponseData data}) {
    print("Status Code: ${data.statusCode}");
    print("Method: ${data.method}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
    print("Headers: ${data.headers}");
  }
}

class AddBarrier extends MiddlewareContract {
  @override
  interceptRequest({RequestData data}) {

    data.headers.addAll({'authorization':CustomHttp.accessToken});
  }

  @override
  interceptResponse({ResponseData data}) {
  }
}