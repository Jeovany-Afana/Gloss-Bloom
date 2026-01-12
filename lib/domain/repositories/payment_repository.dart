import 'package:gloss_bloom/domain/entities/payment_info.dart';

class PaymentRequest {
  final PaymentProvider provider;
  final double amount;
  final String currency;
  final String orderId;
  final Map<String, dynamic>? metadata;

  const PaymentRequest({
    required this.provider,
    required this.amount,
    required this.currency,
    required this.orderId,
    this.metadata,
  });
}

class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? reference;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;

  const PaymentResult({
    required this.success,
    this.transactionId,
    this.reference,
    this.errorMessage,
    this.metadata,
  });
}

abstract class PaymentRepository {
  Future<PaymentResult> initiatePayment(PaymentRequest request);
  Future<PaymentResult> confirmPayment(String transactionId);
  Future<PaymentResult> cancelPayment(String transactionId);
  Future<PaymentInfo?> getPaymentStatus(String transactionId);
  Future<List<PaymentProvider>> getAvailableProviders();
}