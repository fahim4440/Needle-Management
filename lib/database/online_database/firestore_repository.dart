import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:needle_management/model/needle_transaction_model.dart';
import '../../model/machine_model.dart';
import '../../model/needle_model.dart';
class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Machine> getMachineData(String machineId) async {
    DocumentSnapshot snapshot = await _firestore.collection("floors").doc("EFL_Ext").collection("machines").doc(machineId).get();
    return Machine.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<List<Needle>> getNeedleData(Machine machine, String needleUsedIn) async {
    QuerySnapshot snapshot = await _firestore.collection("needlesData").where('machineType', isEqualTo: machine.machineType).where('machineBrand', isEqualTo: machine.brand).where('gauge', isEqualTo: machine.gauge).where('needleUsedIn', isEqualTo: needleUsedIn).get();
    List<Needle> needles = [];
    for (DocumentSnapshot doc in snapshot.docs) {
      needles.add(Needle.fromJson(doc.data() as Map<String, dynamic>));
    }
    return needles;
  }

  Future<void> uploadTransaction(NeedleTransaction transaction) async {
    DocumentReference transRef = _firestore.collection('needleTransactions').doc(transaction.transactionId);
    await transRef.set(transaction.toMap());
  }

  Future<void> uploadMachineData() async {
    // Load and parse the JSON file
    String jsonString = await rootBundle.loadString('assets/machine_data.json');
    Map<String, dynamic> machineDataJson = jsonDecode(jsonString);

    // Upload machines
    String floorName = machineDataJson['floorName'];
    int totalMachines = machineDataJson['totalMachine'];
    List<dynamic> machines = machineDataJson['machines'];

    DocumentReference floorRef = _firestore.collection('floors').doc(floorName);

    await floorRef.set({
      'floorName': floorName,
      'totalMachine': totalMachines,
    });

    for(Map<String, dynamic> machine in machines) {
      await floorRef.collection("machines").doc(machine['machineId']).set(machine);
    }

    print("Machine data uploaded successfully");
  }

  Future<void> uploadNeedleData() async {
    // Load and parse the JSON file
    String jsonString = await rootBundle.loadString('assets/needle_data.json');
    Map<String, dynamic> needleDataJson = jsonDecode(jsonString);

    // Upload machines
    List<dynamic> needlesData = needleDataJson['needleData'];

    CollectionReference needleRef = _firestore.collection('needlesData');

    for(Map<String, dynamic> needleData in needlesData) {
      await needleRef.add(needleData);
    }

    print("Needle data uploaded successfully");
  }
}