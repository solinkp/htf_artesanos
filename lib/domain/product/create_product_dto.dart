class CreateProductDTO {
  final String title;
  final String description;
  final double price;
  final double discountPercentage;

  CreateProductDTO({
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
  });
}
