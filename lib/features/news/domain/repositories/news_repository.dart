import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({int page, int pageSize});
  Future<List<Article>> getAllNews({String query, int page, int pageSize});
}
