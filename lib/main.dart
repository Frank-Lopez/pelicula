
import 'package:flutter/material.dart';
 

//mis paquetes
import 'package:pelicula/src/page/home_page.dart';
import 'package:pelicula/src/page/pelicula_detalle.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'      :  (BuildContext context) => Homepage(),
       'detalle' :  (BuildContext context) => PeliculasDetalles(),
      
      },
    );
  }
}
