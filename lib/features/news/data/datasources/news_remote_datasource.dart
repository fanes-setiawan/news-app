import 'package:news_app/features/news/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    int page,
    int pageSize,
  });

  Future<List<ArticleModel>> getAllNews({
    String query,
    int page,
    int pageSize,
  });
}
