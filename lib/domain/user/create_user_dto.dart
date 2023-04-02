class CreateUserDTO {
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  final String username;
  final String password;
  final String gender;

  CreateUserDTO({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.username,
    required this.password,
    required this.gender,
  });
}
