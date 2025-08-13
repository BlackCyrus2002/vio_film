import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/categorie_model.dart';
import '../../pages/description_movie.dart';

class FavoriteGrid extends StatelessWidget {
  final result;
  final Function(Results) bottomSheet;
  const FavoriteGrid({super.key, required this.result, required this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                "https://image.tmdb.org/t/p/w500${result.poster_path}",
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
                  "${result.name} ${result.title}",
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
                            return DescriptionMovie(movie: result);
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
                    onPressed: (() => bottomSheet(result)),
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
  }
}
