import 'package:flutter/material.dart';
import 'package:vio_film/view/widget/home/movie.dart';
import '../../../model/type_watcher.dart';

class HomeMovies extends StatefulWidget {
  const HomeMovies({super.key});

  @override
  State<HomeMovies> createState() => _HomeMoviesState();
}

class _HomeMoviesState extends State<HomeMovies> {
  int page = 1;
  int selectedIndex = 0;

  List<TypeWatcher> typeWatcher = [
    TypeWatcher(type: "Films", state: true),
    TypeWatcher(type: "Séries", state: false),
  ];

  void changePage(int newPage) {
    setState(() {
      page = newPage;
    });
  }

  void onSelect(int index) {
    setState(() {
      for (var i = 0; i < typeWatcher.length; i++) {
        typeWatcher[i].state = i == index;
      }
      selectedIndex = index;
    });
  }

  Widget getCurrentPage() {
    return Expanded(
      child: Movie(
        key: ValueKey(selectedIndex),
        page: page,
        changePage: changePage,
        type: selectedIndex == 0 ? "movie" : "tv",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: typeWatcher.asMap().entries.map((entry) {
            int index = entry.key;
            TypeWatcher type = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ChoiceChip(
                avatar: type.state
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
                showCheckmark: false,
                label: Text(type.type),
                selected: type.state,
                onSelected: (_) => onSelect(index),
                labelStyle: TextStyle(
                  color: type.state ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                selectedColor: Colors.blue,
                backgroundColor: Colors.grey[300],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        getCurrentPage(),
      ],
    );
  }
}
