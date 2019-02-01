
import 'package:tuple/tuple.dart';

Future<Tuple2<T, int>> measureTime<T>(Future<T> Function() func) async {
  final now = DateTime.now();
  final result = await func();

  return new Tuple2(result, DateTime.now().difference(now).inMilliseconds);
}