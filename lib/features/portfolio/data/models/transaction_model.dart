import '../../domain/entities/portfolio_entity.dart';

class TransactionModel {
  final String id;
  final String symbol;
  final String name;
  final String type;
  final double quantity;
  final double price;
  final double amount;
  final DateTime date;

  const TransactionModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.type,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as String? ?? '',
        symbol: json['symbol'] as String? ?? '',
        name: json['name'] as String? ?? '',
        type: json['type'] as String? ?? '',
        quantity: (json['quantity'] as num? ?? 0).toDouble(),
        price: (json['price'] as num? ?? 0).toDouble(),
        amount: (json['amount'] as num? ?? 0).toDouble(),
        date: DateTime.tryParse(json['date'] as String? ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
      );

  TransactionEntity toEntity() => TransactionEntity(
        id: id,
        symbol: symbol,
        name: name,
        type: type,
        quantity: quantity,
        price: price,
        amount: amount,
        date: date,
      );
}
