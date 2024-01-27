import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  final String? nextUrl;

  const DataState({this.data, this.error, this.nextUrl});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data, {String? nextUrl})
      : super(data: data, nextUrl: nextUrl);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
