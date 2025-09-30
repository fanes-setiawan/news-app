part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopHeadlines extends NewsEvent {}

class FetchAllNews extends NewsEvent {
  final String query;
  final int page;

  const FetchAllNews({this.query = "technology", this.page = 1});

  @override
  List<Object?> get props => [query, page];
}
class ScheduleDailyNewsNotification extends NewsEvent {
  final GetAllNews usecase;
  const ScheduleDailyNewsNotification(this.usecase);
}
