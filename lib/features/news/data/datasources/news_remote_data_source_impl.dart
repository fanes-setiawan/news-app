import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  final String apiKey;

  NewsRemoteDataSourceImpl({required this.client, required this.apiKey});

  static const String _baseUrl = "https://newsapi.org/v2";

  @override
  Future<List<ArticleModel>> getTopHeadlines({int page = 1, int pageSize = 10}) async {
    final response = await client.get(
      Uri.parse("$_baseUrl/top-headlines?country=us&page=$page&pageSize=$pageSize&apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data["articles"];
      return articles.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load top headlines");
    }
  }

  @override
  Future<List<ArticleModel>> getAllNews({String query = "technology", int page = 1, int pageSize = 10}) async {
    final response = await client.get(
      Uri.parse("$_baseUrl/everything?q=$query&page=$page&pageSize=$pageSize&apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data["articles"];
      return articles.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load all news");
    }
  }
}
