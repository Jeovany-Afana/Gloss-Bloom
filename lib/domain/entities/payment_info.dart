enum PaymentProvider {
  wave,
  orangeMoney,
  freeMoney,
  payDunya,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  cancelled,
}

class PaymentInfo {
  final PaymentProvider provider;
  final PaymentStatus status;
  final double amount;
  final String currency;
  final String? reference;
  final String? transactionId;
  final DateTime? paidAt;

  const PaymentInfo({
    required this.provider,
    required this.status,
    required this.amount,
    required this.currency,
    this.reference,
    this.transactionId,
    this.paidAt,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      provider: PaymentProvider.values.byName(json['provider']),
      status: PaymentStatus.values.byName(json['status']),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      reference: json['reference'],
      transactionId: json['transactionId'],
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider.name,
      'status': status.name,
      'amount': amount,
      'currency': currency,
      'reference': reference,
      'transactionId': transactionId,
      'paidAt': paidAt?.toIso8601String(),
    };
  }
}