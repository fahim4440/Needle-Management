import 'package:cloud_firestore/cloud_firestore.dart';

class NeedleTransaction {
  final String transactionId;
  final String needleNumber;
  final String? machineId;
  final String transactionType; // "purchase" or "use"
  final int quantity;
  final DateTime transactionDate;
  final String? reason; // Optional field, used only for "use" transactions
  final int? shift;
  final int submittedBy;

  NeedleTransaction({
    required this.transactionId,
    required this.needleNumber,
    this.machineId,
    required this.transactionType,
    required this.quantity,
    required this.transactionDate,
    this.reason,
    this.shift,
    required this.submittedBy,
  });

  // Convert a NeedleTransaction instance to a map (for Firestore).
  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'needleNumber': needleNumber,
      'transactionType': transactionType,
      'machineId': machineId,
      'quantity': quantity,
      'transactionDate': transactionDate,
      'reason': reason,
      'shift': shift,
      'submittedBy': submittedBy,
    };
  }

  // Create a NeedleTransaction instance from a Firestore document.
  factory NeedleTransaction.fromMap(Map<String, dynamic> map) {
    return NeedleTransaction(
      transactionId: map['transactionId'] as String,
      needleNumber: map['needleNumber'] as String,
      transactionType: map['transactionType'] as String,
      machineId: map['machineId'] as String?,
      quantity: map['quantity'] as int,
      transactionDate: (map['transactionDate'] as Timestamp).toDate(),
      reason: map['reason'] as String?,
      shift: map['shift'] as int?,
      submittedBy: map['submittedBy'] as int,
    );
  }
}
