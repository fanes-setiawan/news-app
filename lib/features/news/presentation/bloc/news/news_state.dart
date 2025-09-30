import 'package:equatable/equatable.dart';
import '../../../domain/entities/article.dart';

class NewsState extends Equatable {
  final List<Article> topHeadlines;
  final List<Article> allNews;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;

  const NewsState({
    this.topHeadlines = const [],
    this.allNews = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
  });

  NewsState copyWith({
    List<Article>? topHeadlines,
    List<Article>? allNews,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
  }) {
    return NewsState(
      topHeadlines: topHeadlines ?? this.topHeadlines,
      allNews: allNews ?? this.allNews,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props =>
      [topHeadlines, allNews, isLoading, isLoadingMore, error, currentPage];
}
