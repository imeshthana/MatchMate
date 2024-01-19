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
    List<String> favourites;
      List<String> requests;
        List<String> pendings;
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
    required this.favourites,
    required this.requests,
    required this.pendings,
  });
}
