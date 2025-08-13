
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/categorie_model.dart';
import '../../pages/description_movie.dart';

class NoSearch extends StatelessWidget {
  final CategoryModel? list;
  final Function(Results) bottomSheet;
  const NoSearch({super.key, this.list, required this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: list!.results.map((e) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://image.tmdb.org/t/p/w500${e.poster_path}",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${e.name} ${e.title}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) {
                                  return DescriptionMovie(
                                    movie: e,
                                  );
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.read_more_outlined,
                            color: Colors.blue.shade400,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: (()=>bottomSheet(e)),
                          icon: Icon(
                            Icons.movie_creation,
                            color: Colors.orange.shade400,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
