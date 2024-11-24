import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cartelera_provider.dart';
import '../widgets/pelicula_card.dart';

class CarteleraScreen extends StatelessWidget {
  const CarteleraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Cartelera',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CarteleraProvider>(
        builder: (context, carteleraProvider, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: carteleraProvider.peliculas.length,
            itemBuilder: (context, index) {
              return PeliculaCard(
                pelicula: carteleraProvider.peliculas[index],
              );
            },
          );
        },
      ),
    );
  }
}

