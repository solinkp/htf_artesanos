class UserType {
  final int id;
  final String description;

  UserType({
    required this.id,
    required this.description,
  });

  static List<UserType> defaultTypes() {
    return [
      UserType(id: 0, description: 'Artesano'),
      UserType(id: 1, description: 'Turista'),
    ];
  }
}
