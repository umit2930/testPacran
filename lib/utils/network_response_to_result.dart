import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dobareh_bloc/data/model/error_model.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:logger/logger.dart';

Future<T> generalNetworkResult<T>(T Function(dynamic data) jsonConverter,
    Future<Response<dynamic>> request) async {
  //TODO now we throw the errors. so can we use T instead of dynamic ? i think no , because apiProvider is dynamic.
  Response<dynamic>? response;

  ///check internet
  if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
    throw NoInternetException("اتصال اینترنتی خود را برسی کنید.");
  } else {
    //TODO remove await ??
    await request.then((value) {
      response = value;
    }, onError: (obj, stackTree) {
      Logger().i(obj);
      switch (obj.runtimeType) {
        case DioError:
          //TODO check the status when obj isn't instance of DioError
          response = (obj as DioError).response;
          break;
        default:
          throw UndefinedException(obj.toString());
      }
    });

    ///generate response
    if (response != null) {
      var serverResponse = response!;
      switch (serverResponse.statusCode) {
        case 200:
          T result = jsonConverter(serverResponse.data);
          return result;
        case 400:
          throw BadRequestException(
              ErrorModel.fromJson(serverResponse.data).errors.toString());
        case 401:
          throw UnauthorisedException();
        case 403:
          throw ForbiddenException(
              ErrorModel.fromJson(serverResponse.data).errors.toString());
        case 404:
          throw BadRequestException(
              ErrorModel.fromJson(serverResponse.data).errors.toString());
        case 422:
          throw ApiKeyNotFound();
        default:
          throw UndefinedException();
      }
    } else {
      throw UndefinedException("پاسخی از سمت سرور دریافت نشد.");
    }
  }
}
