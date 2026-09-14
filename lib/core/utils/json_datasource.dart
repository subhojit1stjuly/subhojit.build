abstract class JsonDatasource<T extends JsonSerializable> {
  abstract final List<T> allData;
}

abstract class JsonSerializable {
  const JsonSerializable();
  Map<String, dynamic> toMap();
}
