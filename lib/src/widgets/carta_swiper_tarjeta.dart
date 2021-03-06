import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelicula/src/models/peliculas_modes.dart';


class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  const CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjetas';


          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:GestureDetector(
                onTap: ()=>Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                child: FadeInImage(
                  placeholder:  AssetImage("assets/gif/loading.gif"),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.cover,
            ),
              ),
            ),
          ); 
          
        },
        itemCount: peliculas.length,
        ),
    );
  }
}
