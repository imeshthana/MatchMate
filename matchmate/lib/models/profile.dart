class Profile {
  String username;
  String firstName;
  String lastName;
  int age;
  String gender;
  String occupation;
  String country;
  String state;
  String bio;
  List<String> preferences;
  String profilePicture;

  Profile({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.occupation,
    required this.country,
    required this.state,
    required this.bio,
    required this.preferences,
    required this.profilePicture,
  });
}
