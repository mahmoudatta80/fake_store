import 'package:dio/dio.dart';

class DioHelper {
  static late Dio productDio;
  static late Dio categoryDio;
  static late Dio singleProductDio;

  static init() {
    productDio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/',
        receiveDataWhenStatusError: true,
      ),
    );
    categoryDio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/',
        receiveDataWhenStatusError: true,
      ),
    );
    singleProductDio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getProduct() async{
    return await productDio.get(
      'products',
    );
  }

  static Future<Response> getSingleCategory(String category) async{
    return await categoryDio.get(
      'products/category/$category',
    );
  }

  static Future<Response> getSingleProduct(int id) async{
    return await singleProductDio.get(
      'products/$id',
    );
  }
}