abstract class DataRepository<T> {
  Future<List<T>> getAllData();
  Future<void> addData(T data);
  Future<void> updateData(T data);
  Future<void> deleteData(String id);
}
