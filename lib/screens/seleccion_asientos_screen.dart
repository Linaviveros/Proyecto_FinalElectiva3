import 'package:flutter/material.dart';
import '../models/pelicula.dart';
import '../widgets/asiento_grid.dart';
import 'pago_screen.dart';

class SeleccionAsientosScreen extends StatefulWidget {
  final Pelicula pelicula;

  const SeleccionAsientosScreen({super.key, required this.pelicula});

  @override
  State<SeleccionAsientosScreen> createState() => _SeleccionAsientosScreenState();
}

class _SeleccionAsientosScreenState extends State<SeleccionAsientosScreen> {
  int cantidadBoletos = 1;
  List<String> asientosSeleccionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Asientos - ${widget.pelicula.titulo}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cantidad de Boletos:'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (cantidadBoletos > 1) {
                          setState(() {
                            cantidadBoletos--;
                          });
                        }
                      },
                    ),
                    Text('$cantidadBoletos'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cantidadBoletos++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
  child: AsientoGrid(
    onAsientosChanged: (asientos) {
      setState(() {
        asientosSeleccionados = asientos;
      });
    },
    cantidadBoletos: cantidadBoletos,
    peliculaId: widget.pelicula.id,
  ),
),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total a Pagar: \$${(widget.pelicula.precio * cantidadBoletos).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: asientosSeleccionados.length == cantidadBoletos
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagoScreen(
                                total: widget.pelicula.precio * cantidadBoletos,
                                pelicula: widget.pelicula,
                                asientos: asientosSeleccionados,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Continuar al Pago'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
