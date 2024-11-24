import 'package:flutter/foundation.dart';
import '../models/pelicula.dart';

class CarteleraProvider with ChangeNotifier {
  final List<Pelicula> _peliculas = [
    Pelicula(
      id: 1, 
      titulo: 'Five Nights at Freddy\'s',
      descripcion: 'Un guardia de seguridad comienza a trabajar en Freddy Fazbear\'s Pizza. Durante su primer día, se da cuenta que el turno de noche no será tan fácil de superar.',
      imagen: 'https://image.tmdb.org/t/p/w500/t6RSJ1z8bDEYpk4fLwxfkXciUak.jpg',
      precio: 12.99,
    ),
    Pelicula(
      id: 2,
      titulo: 'The Marvels',
      descripcion: 'Carol Danvers, alias Capitana Marvel, ha recuperado su identidad de los tiránicos Kree. Pero consecuencias no deseadas la obligan a cargar con el peso de un universo desestabilizado.',
      imagen: 'https://image.tmdb.org/t/p/w500/tUtgLOESpCx7ue4BaeCTqp3vn1b.jpg',
      precio: 15.99,
    ),
    Pelicula(
      id: 3,
      titulo: 'Napoleón',
      descripcion: 'Una mirada personal a los orígenes del líder militar francés y su rápido ascenso al imperio. La película captura las batallas más famosas de Napoleón.',
      imagen: 'https://image.tmdb.org/t/p/w500/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg',
      precio: 13.99,
    ),
    Pelicula(
      id: 4,
      titulo: 'Wish',
      descripcion: 'La joven Asha pide un deseo tan poderoso que es respondido por una fuerza cósmica, una pequeña bola de energía ilimitada llamada Estrella.',
      imagen: 'https://image.tmdb.org/t/p/w500/dB6Krk806zeqd0YNp2ngQ9zXteH.jpg',
      precio: 14.99,
    ),
  ];

  List<Pelicula> get peliculas => [..._peliculas];
}

