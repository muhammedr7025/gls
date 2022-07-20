import 'dart:convert';

class DbModel {
  final bool leakage;
  final bool nob;
  final double balance;
  DbModel({
    required this.leakage,
    required this.nob,
    required this.balance,
  });

  DbModel copyWith({
    bool? leakage,
    bool? nob,
    double? balance,
  }) {
    return DbModel(
      leakage: leakage ?? this.leakage,
      nob: nob ?? this.nob,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'leakage': leakage,
      'nob': nob,
      'balance': balance,
    };
  }

  factory DbModel.fromMap(Map<String, dynamic> map) {
    return DbModel(
      leakage: map['leakage'] ?? false,
      nob: map['nob'] ?? false,
      balance: map['balance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DbModel.fromJson(String source) =>
      DbModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'DbModel(leakage: $leakage, nob: $nob, balance: $balance)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DbModel &&
        other.leakage == leakage &&
        other.nob == nob &&
        other.balance == balance;
  }

  @override
  int get hashCode => leakage.hashCode ^ nob.hashCode ^ balance.hashCode;
}
