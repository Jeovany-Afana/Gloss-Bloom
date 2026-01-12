class CartItem {
  final String productId;
  final String variantId;
  final String variantName;
  final int quantity;
  final double unitPrice;
  final String? productName;
  final String? productImage;
  final String? vendorName;

  const CartItem({
    required this.productId,
    required this.variantId,
    required this.variantName,
    required this.quantity,
    required this.unitPrice,
    this.productName,
    this.productImage,
    this.vendorName,
  });

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? productId,
    String? variantId,
    String? variantName,
    int? quantity,
    double? unitPrice,
    String? productName,
    String? productImage,
    String? vendorName,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      vendorName: vendorName ?? this.vendorName,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      variantId: json['variantId'],
      variantName: json['variantName'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      productName: json['productName'],
      productImage: json['productImage'],
      vendorName: json['vendorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'variantId': variantId,
      'variantName': variantName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productName': productName,
      'productImage': productImage,
      'vendorName': vendorName,
    };
  }
}