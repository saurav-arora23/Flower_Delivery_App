class DataFields {
  static const String tableName = 'users';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT';
  static const String id = 'id';
  static const String email = 'email';
  static const String password = 'password';

  static const List<String> values = [
    id,
    email,
    password,
  ];
}
