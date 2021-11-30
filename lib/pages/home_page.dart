import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practica_final/services/doggy_service.dart';
import 'package:practica_final/widgets/header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final doggyProvider = Provider.of<DoggyService>(context);
    final size = MediaQuery.of(context).size;
    // double temperatura = 20.0;
    double distancia = 0.0;

    Future.delayed(const Duration(seconds: 30), () async {
      doggyProvider.obtenerTemperatura();
      doggyProvider.obtenerDistancia();
      // distancia = doggyProvider.dist;

      setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mi Hogarcito'),
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
      ),
      body: Container(
        color: const Color(0xffededed),
        child: Stack(
          children: [
            Header(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height / 4,
                        child: const Image(
                          image: AssetImage(
                            'images/Conan.png',
                          ),
                        ),
                      ),
                      Text(
                        '${doggyProvider.temp}°C',
                        style: const TextStyle(
                          fontSize: 55,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Conan House',
                    style: TextStyle(fontSize: 35),
                  ),
                  Container(
                    height: size.height / 2.6,
                    width: double.infinity,
                    margin: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (doggyProvider.dist > 20)
                            ? const Text(
                                'La casita está vacía',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              )
                            : (doggyProvider.dist < 19 &&
                                    doggyProvider.dist > 12)
                                ? const Text(
                                    'El perrito quiere salir',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                : const Text(
                                    'Hay un Perrito en casa',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                        OptionButton(
                          text: 'Abrir Puerta',
                          onPressed: () async {
                            doggyProvider.abrirPuerta();
                          },
                        ),
                        OptionButton(
                          text: 'Cerrar Puerta',
                          onPressed: () async {
                            doggyProvider.cerrarPuerta();
                          },
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: -5.0,
                          offset: Offset(0.0, 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const OptionButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 70,
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
