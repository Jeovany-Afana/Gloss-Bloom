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
}