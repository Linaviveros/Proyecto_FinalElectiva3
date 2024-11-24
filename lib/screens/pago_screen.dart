import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pelicula.dart';

class PagoScreen extends StatefulWidget {
  final double total;
  final Pelicula pelicula;
  final List<String> asientos;

  const PagoScreen({
    super.key,
    required this.total,
    required this.pelicula,
    required this.asientos,
  });

  @override
  State<PagoScreen> createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroTarjetaController = TextEditingController();
  final _fechaVencimientoController = TextEditingController();
  final _cvvController = TextEditingController();

  void _procesarPago() async {
  if (_formKey.currentState!.validate()) {
    try {
      for (final asiento in widget.asientos) {
        await FirebaseFirestore.instance
            .collection('peliculas')
            .doc(widget.pelicula.id.toString())
            .collection('asientos')
            .doc(asiento)
            .set({'ocupado': true});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pago procesado con éxito!')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print('Error al procesar el pago: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumen de Compra',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text('Película: ${widget.pelicula.titulo}'),
              Text('Asientos: ${widget.asientos.join(", ")}'),
              Text('Total a Pagar: \$${widget.total.toStringAsFixed(2)}'),
              const SizedBox(height: 24),
              const Text('Método de Pago'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroTarjetaController,
                decoration: const InputDecoration(
                  labelText: 'Número de Tarjeta',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (value.length < 16) {
                    return 'Número de tarjeta inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fechaVencimientoController,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de Vencimiento',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        if (value.length != 3) {
                          return 'CVV inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _procesarPago,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Pagar Ahora'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
