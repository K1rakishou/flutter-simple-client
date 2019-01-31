import 'package:flutter_simple_client/data/datasource/local/PhotosLocalDataSource.dart';
import 'package:flutter_simple_client/data/datasource/remote/PhotosRemoteDataSource.dart';
import 'package:flutter_simple_client/data/datasource/remote/api/ApiService.dart';
import 'package:flutter_simple_client/data/repository/PhotosRepository.dart';
import 'package:flutter_simple_client/features/PhotosBlock.dart';
import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;


void initKiwi() {
  Container().registerSingleton((c) => PhotosLocalDataSource());
  Container().registerSingleton((c) => http.Client());
  Container().registerSingleton((c) => ApiService(c.resolve()));
  Container().registerSingleton((c) => PhotosRemoteDataSource(c.resolve()));
  Container().registerSingleton((c) => PhotosRepository(c.resolve(), c.resolve()));

  Container().registerFactory((c) => PhotosBloc(c.resolve()));
}