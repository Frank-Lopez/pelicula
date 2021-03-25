import 'package:flutter/material.dart';
import 'package:pelicula/src/models/actores_mod.dart';
import 'package:pelicula/src/models/peliculas_modes.dart';
import 'package:pelicula/src/provider/peliculas_provider.dart';

class PeliculasDetalles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context).settings.arguments as Pelicula;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(context, pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, pelicula),
            _descripcion(context, pelicula),
            _crearCasting(context, pelicula),
          ]),
        )

        //SliverFillRemaining(),
      ],
    ));
  }
}

Widget _crearAppbar(BuildContext context, Pelicula pelicula) {
  return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigo,
    expandedHeight: 250.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 15.0)),
      background: FadeInImage(
        image: NetworkImage(pelicula.getBackgroundImg()),
        placeholder: AssetImage('assets/gif/loading.gif'),
        fadeInDuration: Duration(milliseconds: 10),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      children: <Widget>[
        Hero(
          tag: pelicula.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 200.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ignore: deprecated_member_use
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(pelicula.releaseDate,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _descripcion(BuildContext context, Pelicula pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    child: Text(
      pelicula.overview,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 18.0,
      ),
    ),
  );
}

Widget _crearCasting(BuildContext context, Pelicula pelicula) {
  final peliProvider = PeliculaProvider();

  return FutureBuilder(
    future: peliProvider.getCast(pelicula.id.toString()),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return _crearActoresPageview(snapshot.data);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _crearActoresPageview(List<Actor> actores) {
  return SizedBox(
    height: 200.0,
    child: PageView.builder(
      pageSnapping: false,
      controller: PageController(
        viewportFraction: 0.3,
        initialPage: 1,
      ),
      itemCount: actores.length,
      itemBuilder: (BuildContext context, int i) =>_actorTarjeta(actores[i], context),
      
    ),
  );
}

Widget _actorTarjeta(Actor actor, BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image:NetworkImage(actor.getFoto()),
           placeholder:  AssetImage("assets/imagen/no-imagen.jpg"),
            height: 150.0,
            fit: BoxFit.cover,
             ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,)
      ],
    ),
  );
}
