import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/core/theme/theme_cubit.dart';
import 'package:news_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news/news_state.dart';
import 'package:news_app/features/news/presentation/widget/news_card.dart';
import 'package:news_app/features/news/presentation/widget/section_header.dart';
import 'news_detail_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final bloc = context.read<NewsBloc>();
        if (!bloc.state.isLoadingMore) {
          bloc.add(
            FetchAllNews(query: "technology", page: bloc.state.currentPage + 1),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SectionHeader(title: "News App"),
        actions: [
         
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),

      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.isLoading && state.topHeadlines.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            controller: _scrollController,
            children: [
              // ===== Top Headlines =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Headlines",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (state.topHeadlines.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    height: 160.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: state.topHeadlines.map((article) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailPage(article: article),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: article.urlToImage != null
                              ? DecorationImage(
                                  image: NetworkImage(article.urlToImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            color: Colors.black54,
                            child: Text(
                              article.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              // ===== All News =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All News",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...state.allNews.map((article) {
                return NewsCard(
                  article: article,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailPage(article: article),
                      ),
                    );
                  },
                );
              }),

              // Loader saat pagination
              if (state.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
