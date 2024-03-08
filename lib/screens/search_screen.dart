import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final List<Map<String, dynamic>> searchData =
        await _apiService.searchMovies(_searchController.text);
    setState(() {
      _searchResults = searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search movies....',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults.clear();
                          });
                        },
                        icon: const Icon(Icons.clear)),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final Movie movie = _searchResults[index];
                ListTile(
                  leading: Image.network(
                    movie.posterPath != '' ?
                    'https://image/tmdb.org/t/p/w500${movie.posterPath}' :
                    'https://via.placeholder.com/50x75?text=No+Image',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
