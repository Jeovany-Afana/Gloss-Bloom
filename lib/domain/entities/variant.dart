class Variant {
  final String id;
  final String name;
  final String hexColor;
  final double price;
  final String? sku;
  final int stock;
  final bool isAvailable;

  const Variant({
    required this.id,
    required this.name,
    required this.hexColor,
    required this.price,
    this.sku,
    this.stock = 0,
    this.isAvailable = true,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      name: json['name'],
      hexColor: json['hexColor'],
      price: (json['price'] as num).toDouble(),
      sku: json['sku'],
      stock: json['stock'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hexColor': hexColor,
      'price': price,
      'sku': sku,
      'stock': stock,
      'isAvailable': isAvailable,
    };
  }
}