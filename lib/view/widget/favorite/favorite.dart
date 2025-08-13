import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vio_film/view/widget/favorite/favorite_grid.dart';
import 'package:vio_film/view/widget/preview.dart';
import '../../../model/categorie_model.dart';
import '../../../model/favorites_model.dart';
import '../../../services/category_api.dart';
import '../../../services/database_client.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool see = false;
  List<Favorites>? myFavorite;
  CategoryModel? list;

  @override
  void initState() {
    getAllFavorites();
    callAPI();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (myFavorite == null || list == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (myFavorite!.isEmpty) return Center(child: Text("Vous n'avez aucun favori"),);

    // Créer un set pour accès rapide
    final favoriteIDs = myFavorite!.map((fav) => fav.typeID).toSet();

    // Filtrer la liste API
    final filteredResults = list!.results
        .where((res) => favoriteIDs.contains(res.id))
        .toList();
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mes favories",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: filteredResults.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final result = filteredResults[index];
                return FavoriteGrid(result: result, bottomSheet: bottomSheet);
              },
            ),
          ),
        ],
      ),
    );
  }

  getAllFavorites() async {
    myFavorite = await DataBaseClient().allFavoritesList();
    setState(() {});
  }

  callAPI() async {
    final data = await APIService().callAPI(1, "movie");
    final data2 = await APIService().callAPI(1, "tv");
    setState(() {
      list = data;
      list!.results.addAll(data2.results);
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
}
