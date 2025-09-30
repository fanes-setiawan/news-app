import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  const NewsCard({super.key, required this.article, this.onTap});

  String formatDate(String? date) {
    if (date == null) return "-";
    try {
      final parsed = DateTime.parse(date);
      return DateFormat("dd MMM yyyy, HH:mm").format(parsed);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.sourceName ?? "Unknown",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blue)),
                    const SizedBox(height: 4),
                    Text(article.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(formatDate(article.publishedAt),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(article.urlToImage!,
                    width: 100, height: 80, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}
