class ApiConstants {
  static ApiConstants? _instance;
  static ApiConstants get instance {
    _instance ??= ApiConstants._init();

    return _instance!;
  }

  ApiConstants._init();

  String commentsLink = 'https://jsonplaceholder.typicode.com/comments';
}
