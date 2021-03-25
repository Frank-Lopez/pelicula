import 'package:flutter/material.dart';
import 'package:pelicula/src/models/peliculas_modes.dart';

class MoviHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePage;
  MoviHorizontal({@required this.peliculas, @required this.siguientePage});

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: true,
        controller: _pageController,
        //children: _tarjetas(context),
        // ignore: always_specify_types
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) =>
            _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

     pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(children: <Widget>[
        Hero(
          tag: pelicula.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/gif/loading.gif"),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 130.0,
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          pelicula.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        )
      ]),
    );

    return GestureDetector(
        child: tarjeta,
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        });
  }
}
