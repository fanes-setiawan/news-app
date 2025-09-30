import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/core/theme/theme_cubit.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source_impl.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news.dart';
import 'package:news_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/pages/news_page.dart';

void main() {
  final client = http.Client();
  const apiKey = "aeb0fce6eec946fd8ea5897d41420f4f";

  final remote = NewsRemoteDataSourceImpl(client: client, apiKey: apiKey);
  final repo = NewsRepositoryImpl(remote);
  final getTopHeadlines = GetTopHeadlines(repo);
  final getAllNews = GetAllNews(repo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsBloc(
            getTopHeadlines: getTopHeadlines,
            getAllNews: getAllNews,
          )
            ..add(FetchTopHeadlines())
            ..add(FetchAllNews(query: "technology")),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(), // 🔥 ini wajib
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'News App',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          home: const NewsPage(),
        );
      },
    );
  }
}
