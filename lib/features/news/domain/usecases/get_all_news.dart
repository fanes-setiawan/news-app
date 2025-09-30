import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetAllNews implements UseCase<List<Article>, GetAllNewsParams> {
  final NewsRepository repo;

  GetAllNews(this.repo);

  @override
  Future<List<Article>> call(GetAllNewsParams params) {
    return repo.getAllNews(query: params.query);
  }
}

class GetAllNewsParams {
  final String query;
  final int page;

  const GetAllNewsParams(this.query, this.page);
}
