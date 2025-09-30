import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines implements UseCase<List<Article>, NoParams> {
  final NewsRepository repo;

  GetTopHeadlines(this.repo);

  @override
  Future<List<Article>> call(NoParams params) {
    return repo.getTopHeadlines();
  }
}
