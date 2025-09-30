import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String url;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? publishedAt;
  final String? author;
  final String? sourceName;

  const Article({
    required this.title,
    required this.url,
    this.description,
    this.urlToImage,
    this.content,
    this.publishedAt,
    this.author,
    this.sourceName,
  });

  @override
  List<Object?> get props => [title, url];
}
