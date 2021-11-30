import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final/models/distancia_model.dart';
import 'package:practica_final/models/temperatura_model.dart';

class DoggyService extends ChangeNotifier {
  final _accessToken = '40fea36943f058efd728c1a4f864016c0da6944e';
  final _deviceID = '44002d000f47363336383437';

  double _temperatura = 0.0;

  Future<void> abrirPuerta() async {
    var url = 'https://api.particle.io/v1/devices/$_deviceID/casita';
    var formData = <String, String>{
      'access_token': _accessToken,
      'params': 'on',
    };
    var response = await http.post(Uri.parse(url), body: formData);
  }

  Future<void> cerrarPuerta() async {
    var url = 'https://api.particle.io/v1/devices/$_deviceID/casita';
    var formData = <String, String>{
      'access_token': _accessToken,
      'params': 'off',
    };
    var response = await http.post(Uri.parse(url), body: formData);
  }

  Future<void> obtenerTemperatura() async {
    String url =
        'https://api.particle.io/v1/devices/44002d000f47363336383437/gradosC?access_token=40fea36943f058efd728c1a4f864016c0da6944e';

    TemperaturaModel temperatura = TemperaturaModel();

    final resp = await http.get(Uri.parse(url));

    final x = jsonDecode(resp.body);

    temperatura = TemperaturaModel.fromJson(x);

    _temperatura = temperatura.result!;

    notifyListeners();
  }

  get temp {
    return _temperatura.toStringAsFixed(0);
  }

  double _distancia = 0.0;

  Future<void> obtenerDistancia() async {
    String url =
        'https://api.particle.io/v1/devices/44002d000f47363336383437/distancia?access_token=40fea36943f058efd728c1a4f864016c0da6944e';

    DistanciaModel distancia = DistanciaModel();

    final resp = await http.get(Uri.parse(url));

    final x = jsonDecode(resp.body);

    distancia = DistanciaModel.fromJson(x);

    _distancia = distancia.result!;

    notifyListeners();
  }

  get dist {
    return _distancia;
  }
}
