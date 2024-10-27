class Machine {
  String machineId;
  String brand;
  String origin;
  String machineType;
  int manufacturingYear;
  int dia;
  int gauge;
  int feederNo;

  // Constructor
  Machine({
    required this.machineId,
    required this.brand,
    required this.origin,
    required this.machineType,
    required this.manufacturingYear,
    required this.dia,
    required this.gauge,
    required this.feederNo,
  });

  // Factory method to create Machine from JSON
  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      machineId: json['machineId'],
      brand: json['brand'],
      origin: json['origin'],
      machineType: json['machineType'],
      manufacturingYear: json['manufacturingYear'],
      dia: json['dia'],
      gauge: json['gauge'],
      feederNo: json['feederNo'],
    );
  }

  // Method to convert Machine to JSON
  Map<String, dynamic> toJson() {
    return {
      'machineId': machineId,
      'brand': brand,
      'origin': origin,
      'machineType': machineType,
      'manufacturingYear': manufacturingYear,
      'dia': dia,
      'gauge': gauge,
      'feederNo': feederNo,
    };
  }
}
