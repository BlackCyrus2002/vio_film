import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vio_film/model/categorie_model.dart';
import 'package:vio_film/model/cover_model.dart';
import 'package:vio_film/provider/share.dart';
import 'package:vio_film/services/cover_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../model/favorites_model.dart';
import '../../services/database_client.dart';

class Preview extends StatefulWidget {
  final Results movie;

  const Preview({super.key, required this.movie});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late YoutubePlayerController _videoController;
  CoverModel? coverModel;
  String? type_video;
  bool favorite = false;
  List<Favorites> myFavorite = [];

  @override
  void initState() {
    getState();
    super.initState();
    _videoController = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
    callAPI();
  }

  callAPI() async {
    if (widget.movie.name.isNotEmpty) {
      type_video = "tv";
    } else {
      type_video = "movie";
    }
    final data = await CoverService().callAPI(widget.movie.id, type_video!);
    setState(() {
      coverModel = data;
    });
    if (coverModel != null && coverModel!.results.isNotEmpty) {
      _videoController.loadVideoById(videoId: coverModel!.results[0].key);
    } else {
      _videoController.loadVideoById(videoId: "43R9l7EkJwE");
    }
  }

  @override
  void dispose() {
    _videoController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Skeletonizer(
        enabled: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: YoutubePlayer(
                    controller: _videoController,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.movie.title}${widget.movie.name}",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Sortie : ${widget.movie.release_date} ${widget.movie.first_air_date}",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (() =>
                      context.read<ShareProvider>().share(widget.movie)),
                  icon: Icon(Icons.share, color: Colors.yellow.shade900),
                ),
                IconButton(
                  onPressed: (() => addFavorite(widget.movie.id, "movie")),
                  icon: Icon(
                    favorite ? Icons.favorite : Icons.favorite_border,
                    color: favorite ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addFavorite(int id, String type) async {
    await DataBaseClient().addFavorite(id, type).then((success) => true);
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
