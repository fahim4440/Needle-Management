import 'dart:convert';

class Needle {
  final String brand;
  final String needleNumber;
  final int dia;
  final int gauge;
  final String machineType;
  final String machineBrand;
  final String needleUsedIn;
  final List<String> compatibleMachines;
  final int totalStock;
  final int usedStock;
  final int remainingStock;
  final double price;

  Needle({
    required this.brand,
    required this.needleNumber,
    required this.dia,
    required this.gauge,
    required this.machineType,
    required this.machineBrand,
    required this.needleUsedIn,
    required this.compatibleMachines,
    required this.totalStock,
    required this.usedStock,
    required this.remainingStock,
    required this.price,
  });

  // Convert JSON to Needle instance
  factory Needle.fromJson(Map<String, dynamic> json) {
    return Needle(
      brand: json['brand'],
      needleNumber: json['needleNumber'],
      dia: json['dia'],
      gauge: json['gauge'],
      machineType: json['machineType'],
      machineBrand: json['machineBrand'],
      needleUsedIn: json['needleUsedIn'],
      compatibleMachines: List<String>.from(json['compatibleMachines']),
      totalStock: json['totalStock'],
      usedStock: json['usedStock'],
      remainingStock: json['remainingStock'],
      price: json['price'].toDouble(),
    );
  }

  // Convert Needle instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'needleNumber': needleNumber,
      'dia': dia,
      'gauge': gauge,
      'machineType': machineType,
      'machineBrand': machineBrand,
      'needleUsedIn': needleUsedIn,
      'compatibleMachines': compatibleMachines,
      'totalStock': totalStock,
      'usedStock': usedStock,
      'remainingStock': remainingStock,
      'price': price,
    };
  }
}