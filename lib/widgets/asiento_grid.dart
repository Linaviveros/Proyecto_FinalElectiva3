import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AsientoGrid extends StatefulWidget {
  final Function(List<String>) onAsientosChanged;
  final int cantidadBoletos;
  final int peliculaId;

  const AsientoGrid({
    super.key,
    required this.onAsientosChanged,
    required this.cantidadBoletos,
    required this.peliculaId,
  });

  @override
  State<AsientoGrid> createState() => _AsientoGridState();
}

class _AsientoGridState extends State<AsientoGrid> {
  final Set<String> asientosSeleccionados = {};
  Set<String> asientosOcupados = {};

  @override
  void initState() {
    super.initState();
    _cargarAsientosOcupados();
  }

  Future<void> _cargarAsientosOcupados() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('peliculas')
          .doc(widget.peliculaId.toString())
          .collection('asientos')
          .get();

      final ocupados = snapshot.docs
          .where((doc) => doc['ocupado'] == true)
          .map((doc) => doc.id)
          .toSet();

      setState(() {
        asientosOcupados = ocupados;
      });
    } catch (e) {
      print('Error al cargar asientos ocupados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('PANTALLA', style: TextStyle(fontSize: 20)),
        ),
        const Divider(thickness: 2),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 64, // 8x8 grid
            itemBuilder: (context, index) {
              final fila = String.fromCharCode(65 + (index ~/ 8)); // A-H
              final columna = (index % 8) + 1; // 1-8
              final asientoId = '$fila$columna';

              final estaOcupado = asientosOcupados.contains(asientoId);
              final estaSeleccionado = asientosSeleccionados.contains(asientoId);

              return GestureDetector(
                onTap: estaOcupado
                    ? null
                    : () {
                        setState(() {
                          if (estaSeleccionado) {
                            asientosSeleccionados.remove(asientoId);
                          } else if (asientosSeleccionados.length <
                              widget.cantidadBoletos) {
                            asientosSeleccionados.add(asientoId);
                          }
                          widget.onAsientosChanged(asientosSeleccionados.toList());
                        });
                      },
                child: Container(
                  decoration: BoxDecoration(
                    color: estaOcupado
                        ? Colors.grey
                        : estaSeleccionado
                            ? Colors.green
                            : Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      asientoId,
                      style: TextStyle(
                        color: estaSeleccionado || estaOcupado
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLeyenda(Colors.blue[100]!, 'Disponible'),
              _buildLeyenda(Colors.green, 'Seleccionado'),
              _buildLeyenda(Colors.grey, 'Ocupado'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeyenda(Color color, String texto) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(texto),
      ],
    );
  }
}
