import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vio_film/view/pages/description_movie.dart';
import 'package:vio_film/view/pages/loading.dart';
import 'package:vio_film/view/widget/preview.dart';

import '../../../model/categorie_model.dart';
import '../../../services/category_api.dart';

class Movie extends StatefulWidget {
  int page;
  String type;
  Function(int) changePage;

  Movie({
    super.key,
    required this.page,
    required this.changePage,
    required this.type,
  });

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  CategoryModel? categoryModel;
  int? previousPage;

  @override
  void initState() {
    super.initState();
    newCall(widget.page, widget.type);
  }

  @override
  void didUpdateWidget(covariant Movie oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page != widget.page) {
      newCall(widget.page, widget.type);
    }
  }

  newCall(int page, String type) async {
    final data = await APIService().callAPI(page, type);
    setState(() {
      categoryModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (categoryModel == null) {
      return Loading();
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categoryModel!.results.length,
              itemBuilder: (context, index) {
                final movie = categoryModel!.results[index];
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) {
                                    return DescriptionMovie(
                                      movie: movie,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/w500${movie.poster_path}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${movie.title} ${movie.name}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Sortie : ${movie.release_date} ${movie.first_air_date}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Note : ${movie.vote_average}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Langue : ${movie.original_language}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade300,
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) {
                                            return DescriptionMovie(
                                              movie: movie,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.short_text_outlined),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      bottomSheet(movie);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange.shade300,
                                      foregroundColor: Colors.black,
                                    ),
                                    child: Icon(Icons.video_collection),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (widget.page > 1)
                  ? IconButton(
                      onPressed: () {
                        if (widget.page > 1) widget.changePage(widget.page - 1);
                      },
                      icon: Icon(Icons.arrow_circle_left_outlined, size: 30),
                    )
                  : Container(),
              SizedBox(width: 10),
              Text(
                "${widget.page}",
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  widget.changePage(widget.page + 1);
                },
                icon: Icon(Icons.arrow_circle_right_outlined, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bottomSheet(movie) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Preview(movie: movie);
      },
    );
  }
}
