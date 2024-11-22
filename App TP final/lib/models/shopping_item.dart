class ShoppingItem {
  String name;
  String quantity;
  Uri? image;

  ShoppingItem({required this.name, required this.quantity, this.image});

  Map toMap() {
    final result = {
      'name': name,
      'quantity': quantity,
    };

    if (image != null) {
      result['image_url'] = image.toString();
    }

    return result;
  }

  static ShoppingItem fromMap(Map map) {
    return ShoppingItem(
      name: map['name'],
      quantity: map['quantity'],
      image: map['image_url'],
    );
  }
}
