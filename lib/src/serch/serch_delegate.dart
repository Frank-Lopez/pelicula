import 'package:flutter/material.dart';
import 'package:pelicula/src/models/peliculas_modes.dart';
import 'package:pelicula/src/provider/peliculas_provider.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class DataSearch extends SearchDelegate<dynamic> {
  String seleccion = '';
  final peliculasprovider = PeliculaProvider();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del Apbar, ejemplo, limpiar o cancelar busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blue[300],
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen al escribir

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasprovider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
     
        if(snapshot.hasData){
     
        final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((Pelicula pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage("assets/imagen/no-imagen.jpg"),
                   width: 50.0,
                   fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.voteAverage.toString(),),
                onTap:(){
                  close(context, null);
                  pelicula.uniqueId='';
                  Navigator.pushNamed(context, 'detalle', arguments:  pelicula);
                } ,
                
                );
            }).toList()
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
