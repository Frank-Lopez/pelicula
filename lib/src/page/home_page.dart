import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelicula/src/models/peliculas_modes.dart';
import 'package:pelicula/src/provider/peliculas_provider.dart';
import 'package:pelicula/src/serch/serch_delegate.dart';
import 'package:pelicula/src/widgets/carta_swiper_tarjeta.dart';
import 'package:pelicula/src/widgets/movi_horizontal.dart';

class Homepage extends StatelessWidget {
  final peliculasProvider = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text('Pelicula en Cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                showSearch<dynamic>(context:context , delegate:DataSearch(), );
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Populares',
                      style: Theme.of(context).textTheme.headline6)),
              SizedBox(
                height: 5.0,
              ),
              StreamBuilder(
                  stream: peliculasProvider.popularesStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return MoviHorizontal(
                        peliculas: snapshot.data,
                        siguientePage: peliculasProvider.getPopulares,
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  })
            ]));
  }
}
