import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vio_film/view/widget/preview.dart';
import 'package:vio_film/view/widget/search/no_search.dart';
import 'package:vio_film/view/widget/search/search_result.dart';

import '../../../model/categorie_model.dart';
import '../../../services/category_api.dart';
import '../../../services/preferences.dart';
import '../../pages/description_movie.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _controller;
  CategoryModel? list;
  bool isSearch = false;
  CategoryModel? results;
  List<String> movie_title = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    callAPI();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              controller: _controller,
              padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
              trailing: [Icon(Icons.search)],
              hintText: "Rechercher",
              onChanged: (value) {
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    isSearch = true;
                  } else {
                    isSearch = false;
                  }
                  search(_controller.text);
                });
              },
              onSubmitted: (value) {
                addTitle(value);
              },
            ),
            (movie_title.isEmpty)
                ? Container()
                : (isSearch)?Container():Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mes recherches",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movie_title.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(movie_title[index]),
                          trailing: IconButton(
                            onPressed: (()=>removeTitle(movie_title[index])),
                            icon: Icon(Icons.highlight_remove),
                          ),
                          onTap: (){
                            setState(() {
                              _controller.text = movie_title[index];
                              isSearch = true;
                              search(_controller.text);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Nos films et séries",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            isSearch
                ? SearchResult(results: results, bottomSheet: bottomSheet)
                : NoSearch(list: list, bottomSheet: bottomSheet),
          ],
        ),
      ),
    );
  }

  callAPI() async {
    final data = await APIService().callAPI(1, "movie");
    final data2 = await APIService().callAPI(1, "tv");
    setState(() {
      list = data;
      list!.results.addAll(data2.results);
    });
  }

  void search(String text) {
    final filtered = list!.results
        .where(
          (element) =>
              (element.name != null &&
                  element.name.toLowerCase().contains(text.toLowerCase())) ||
              (element.title != null &&
                  element.title.toLowerCase().contains(text.toLowerCase())),
        )
        .toList();

    setState(() {
      results = CategoryModel(
        results: filtered,
        page: list!.page,
        total_pages: list!.total_pages,
        total_results: list!.total_results,
      );
    });
  }

  bottomSheet(movie) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Preview(movie: movie);
      },
    );
  }

  //Ajouter une nouvelle un film
  addTitle(String title) async {
    await Preferences().addPreferences(title).then((value) => update());
  }

  //Supprimer
  removeTitle(String title) async {
    await Preferences().removePreferences(title).then((success) => update());
  }

  //Mettre à jour
  update() async {
    movie_title = await Preferences().getPreferences();
    setState(() {});
  }
}
