import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dobareh_bloc/data/model/ErrorModel.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:logger/logger.dart';

typedef JsonConverter<T> = T Function(dynamic data);

/*
typedef NetworkCallBack<T> = void Function(
    Function() onLoading,
    Function(NetworkResult<T> result) onError,
    Function(NetworkResult<T> result) onSuccess);
*/

//TODO create a generic class for Errors
class NetworkResponseToResult<T> {

  //TODO now we throw the errors. so can we use T instead of dynamic ?
  late final Response<dynamic>? response;

  var connectivity = Connectivity();

  Future<T> generalNetworkResult(
      JsonConverter jsonConverter, Future<Response<dynamic>> request) async {
    ///check internet
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      throw NoInternetException("اتصال اینترنتی خود را برسی کنید.");
    } else {
      //TODO remove await ??
      await request.then((value) {
        response = value;
      }).catchError((Object obj) {
        Logger().i(obj);
        switch (obj.runtimeType) {
          case DioError:
            //TODO check the status when obj isn't instance of DioError
            response = (obj as DioError).response;
            break;
          default:
            break;
        }
      });

      ///generate response
      if (response != null) {
        var serverResponse = response!;
        switch (serverResponse.statusCode) {
          case 200:
            T result = jsonConverter(serverResponse.data);
            return result;
          case 401:
            throw UnauthorisedException();
          case 403:
            throw ForbiddenException(ErrorModel.fromJson(serverResponse.data).errors.toString());
          case 404:
            throw BadRequestException(ErrorModel.fromJson(serverResponse.data).errors.toString());
          case 422:
            throw ApiKeyNotFound();
          default:
            throw UndefinedException();
        }
      } else {
        throw UndefinedException();
      }
    }
  }
}
