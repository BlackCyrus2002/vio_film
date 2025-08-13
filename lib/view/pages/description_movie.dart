import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vio_film/services/database_client.dart';

import '../../model/categorie_model.dart';
import '../../model/favorites_model.dart';
import '../../provider/share.dart';

class DescriptionMovie extends StatefulWidget {
  final Results movie;

  const DescriptionMovie({super.key, required this.movie});

  @override
  State<DescriptionMovie> createState() => _DescriptionMovieState();
}

class _DescriptionMovieState extends State<DescriptionMovie> {
  bool favorite = false;
  List<Favorites> myFavorite = [];

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: (()=>context.read<ShareProvider>().share(movie)),
        backgroundColor: Colors.black,
        child: Icon(Icons.share, color: Colors.white),
      ),
      body: Stack(
        children: [
          // Backdrop Image with overlay
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: CachedNetworkImageProvider(
                    "https://image.tmdb.org/t/p/w500${movie.backdrop_path}",
                  ),
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Text(
                    "${movie.title}${movie.name}",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 8,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // Info section
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (context, scrollController) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Infos clés
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile(
                          Icons.language,
                          "${movie.original_language?.toUpperCase()}",
                          "Langue",
                        ),
                        _infoTile(
                          Icons.star,
                          "${movie.vote_average}/10",
                          "Note",
                        ),
                        _infoTile(
                          Icons.calendar_today,
                          "${movie.release_date}${movie.first_air_date}",
                          "Sortie",
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Adulte et like
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            movie.adult ? "🔞 Adulte" : "✔️ Tout public",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: movie.adult
                              ? Colors.red
                              : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (() => addFavorite(movie.id, "movie")),
                          icon: Icon(
                            favorite ? Icons.favorite : Icons.favorite_border,
                            color: favorite ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Description
                    Text(
                      "Résumé",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${movie.overview}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.deepPurple),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.black, fontSize: 15)),
      ],
    );
  }

  addFavorite(int id, String type) async {
    await DataBaseClient().addFavorite(id, type).then((success)=>true);
    setState(() => favorite = !favorite);
  }

  getState() async {
    myFavorite = await DataBaseClient().allFavorites(widget.movie.id);
    for (var like in myFavorite) {
      if (like.typeID == widget.movie.id) {
        setState(() => favorite = true);
      }
    }
  }
}
