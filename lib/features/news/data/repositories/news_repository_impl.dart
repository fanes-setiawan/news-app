import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remote;
  NewsRepositoryImpl(this.remote);

  @override
  Future<List<Article>> getTopHeadlines({int page = 1, int pageSize = 10}) {
    return remote.getTopHeadlines(page: page, pageSize: pageSize);
  }

  @override
  Future<List<Article>> getAllNews({String query = "technology", int page = 1, int pageSize = 10}) {
    return remote.getAllNews(query: query, page: page, pageSize: pageSize);
  }
}
