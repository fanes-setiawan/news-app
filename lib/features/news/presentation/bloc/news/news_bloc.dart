import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news.dart';
import 'news_state.dart';

part 'news_event.dart';



class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlines getTopHeadlines;
  final GetAllNews getAllNews;

  NewsBloc({required this.getTopHeadlines, required this.getAllNews})
      : super(const NewsState()) {
    on<FetchTopHeadlines>(_onFetchTopHeadlines);
    on<FetchAllNews>(_onFetchAllNews);
  }

  Future<void> _onFetchTopHeadlines(
      FetchTopHeadlines event, Emitter<NewsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await getTopHeadlines(const NoParams());
      emit(state.copyWith(isLoading: false, topHeadlines: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchAllNews(
      FetchAllNews event, Emitter<NewsState> emit) async {
    if (event.page == 1) {
      // First load
      emit(state.copyWith(isLoading: true, error: null));
    } else {
      // Load more
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final result = await getAllNews(GetAllNewsParams(event.query, event.page));

      final updatedList = event.page == 1
          ? result
          : [...state.allNews, ...result]; // append for pagination

      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        allNews: updatedList,
        currentPage: event.page,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }
  
}
