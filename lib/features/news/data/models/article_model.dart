import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.title,
    required super.url,
    super.description,
    super.urlToImage,
    super.content,
    super.publishedAt,
    super.author,
    super.sourceName,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'] ?? '',
        url: json['url'] ?? '',
        description: json['description'],
        urlToImage: json['urlToImage'],
        content: json['content'],
        publishedAt: json['publishedAt'],
        author: json['author'],
        sourceName: json['source']?['name'],
      );
}
