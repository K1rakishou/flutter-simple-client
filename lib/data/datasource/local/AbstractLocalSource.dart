
abstract class AbstractLocalSource<T> {
  Future<bool> storeEntities(List<T> entities);
  Future<void> cleanUpOld();
}