// To parse this JSON data, do
//
//     final temperaturaModel = temperaturaModelFromJson(jsonString);

import 'dart:convert';

DistanciaModel temperaturaModelFromJson(String str) =>
    DistanciaModel.fromJson(json.decode(str));

String temperaturaModelToJson(DistanciaModel data) =>
    json.encode(data.toJson());

class DistanciaModel {
  DistanciaModel({
    this.cmd,
    this.name,
    this.result,
    this.coreInfo,
  });

  String? cmd;
  String? name;
  double? result;
  CoreInfo? coreInfo;

  factory DistanciaModel.fromJson(Map<String, dynamic> json) => DistanciaModel(
        cmd: json["cmd"],
        name: json["name"],
        result: json["result"].toDouble(),
        coreInfo: CoreInfo.fromJson(json["coreInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "cmd": cmd,
        "name": name,
        "result": result,
        "coreInfo": coreInfo!.toJson(),
      };
}

class CoreInfo {
  CoreInfo({
    this.lastHeard,
    this.connected,
    this.lastHandshakeAt,
    this.deviceId,
    this.productId,
  });

  DateTime? lastHeard;
  bool? connected;
  DateTime? lastHandshakeAt;
  String? deviceId;
  int? productId;

  factory CoreInfo.fromJson(Map<String, dynamic> json) => CoreInfo(
        lastHeard: DateTime.parse(json["last_heard"]),
        connected: json["connected"],
        lastHandshakeAt: DateTime.parse(json["last_handshake_at"]),
        deviceId: json["deviceID"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "last_heard": lastHeard!.toIso8601String(),
        "connected": connected,
        "last_handshake_at": lastHandshakeAt!.toIso8601String(),
        "deviceID": deviceId,
        "product_id": productId,
      };
}
