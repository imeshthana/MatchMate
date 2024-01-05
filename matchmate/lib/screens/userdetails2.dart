import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar2.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/models/cities_model.dart';
import 'package:matchmate/models/country_state_model.dart' as cs_model;
import 'package:matchmate/screens/country_state_city_repo.dart';
import 'package:matchmate/components/image_picker.dart';
import 'package:matchmate/components/reusable_card.dart';
import 'package:matchmate/screens/match_mates.dart';

late User? loggedInUser;
final _fireStore = FirebaseFirestore.instance;

class Userdetails2 extends StatefulWidget {
  Userdetails2(
      {required this.userName,
      required this.lastName,
      required this.firstName,
      required this.age,
      required this.gender,
      required this.occupation});

  final String userName;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String occupation;

  @override
  State<Userdetails2> createState() => _Userdetails2State();
}

class _Userdetails2State extends State<Userdetails2> {
  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();
  final _auth = FirebaseAuth.instance;

  TextEditingController preferenceController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  List<String> preferences = [];

  // PickedFile? _imageFile;
  // final ImagePicker _picker = ImagePicker();

  List<String> countries = [];
  List<String> states = [];
  List<String> cities = [];
  cs_model.CountryStateModel countryStateModel =
      cs_model.CountryStateModel(error: false, msg: '', data: []);

  CitiesModel citiesModel = CitiesModel(error: false, msg: '', data: []);

  String selectedCountry = 'Select Country';
  String selectedState = 'Select State';
  String selectedCity = 'Select City';
  bool isDataLoaded = false;
  String? bio;

  String finalTextToBeDisplayed = '';

  @override
  void initState() {
    getCountries();
    getCurrentUser();
    super.initState();
  }

  void addPreference() {
    String newPreference = preferenceController.text.trim();
    if (newPreference.isNotEmpty && preferences.length < 3) {
      setState(() {
        preferences.add(newPreference);
        preferenceController.clear();
      });
    }
  }

  void removePreference(String preference) {
    setState(() {
      preferences.remove(preference);
    });
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  getCountries() async {
    countryStateModel = await _countryStateCityRepo.getCountriesStates();
    countries.add('Select Country');
    states.add('Select State');
    cities.add('Select City');
    for (var element in countryStateModel.data) {
      countries.add(element.name);
    }
    isDataLoaded = true;
    setState(() {});
  }

  getStates() async {
    for (var element in countryStateModel.data) {
      if (selectedCountry == element.name) {
        setState(() {
          resetStates();
          resetCities();
        });
        for (var state in element.states) {
          states.add(state.name);
        }
      }
    }
  }

  getCities() async {
    isDataLoaded = false;
    citiesModel = await _countryStateCityRepo.getCities(
        country: selectedCountry, state: selectedState);
    setState(() {
      resetCities();
    });
    for (var city in citiesModel.data) {
      cities.add(city);
    }
    isDataLoaded = true;
    setState(() {});
  }

  resetCities() {
    cities = [];
    cities.add('Select City');
    selectedCity = 'Select City';
    finalTextToBeDisplayed = '';
  }

  resetStates() {
    states = [];
    states.add('Select State');
    selectedState = 'Select State';
    finalTextToBeDisplayed = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Your Country",
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: GradientBoxBorder(
                                  gradient: gradient, width: 2.5)),
                          child: DropdownButton(
                              isExpanded: true,
                              value: selectedCountry,
                              underline: Container(),
                              items: countries
                                  .map((String country) => DropdownMenuItem(
                                      value: country,
                                      child: Text(
                                        country,
                                        style: textStyle,
                                      )))
                                  .toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  selectedCountry = selectedValue!;
                                });

                                if (selectedCountry != 'Select Country') {
                                  getStates();
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Your State",
                          style: textStyle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: GradientBoxBorder(
                                  gradient: gradient, width: 2.5)),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectedState,
                            underline: Container(),
                            items: states
                                .map((String state) => DropdownMenuItem(
                                    value: state,
                                    child: Text(
                                      state,
                                      style: textStyle,
                                    )))
                                .toList(),
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedState = selectedValue!;
                              });
                              if (selectedState != 'Select State') {
                                getCities();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  hintText: 'Add Your Bio',
                  hintStyle: hintTextStyle,
                  border: GradientOutlineInputBorder(
                    gradient: gradient,
                    width: 2.5,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 25),

              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(gradient: gradient, width: 2.5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: preferenceController,
                        decoration: InputDecoration(
                          hintText: 'Add Preference',
                          hintStyle: hintTextStyle,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              icon: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return gradient.createShader(bounds);
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 30.0,
                                ),
                              ),
                              onPressed: () {
                                addPreference();
                              }),
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 0,
                        children: preferences
                            .map(
                              (preference) => Chip(
                                deleteIconColor: kColor1,
                                backgroundColor:
                                    Color.fromRGBO(199, 0, 57, 0.8),
                                label: Text(
                                  preference,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onDeleted: () {
                                  removePreference(preference);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              //imageProfile(context),
              Spacer(),
              MainButton(
                text: 'Create Your Account',
                onPress: () async {
                  await _fireStore
                      .collection('profiles')
                      .doc(widget.userName)
                      .set({
                    'firstname': widget.firstName,
                    'lastname': widget.lastName,
                    'age': widget.age,
                    'gender':widget.gender,
                    'occupation': widget.occupation,
                    'country': selectedCountry,
                    'state': selectedState,
                    'bio': bio,
                    'preferences': preferences,
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MatchMates()));
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}



// Widget imageProfile(BuildContext context) {
//   return Center(
//     child: Stack(
//       children: <Widget>[
//         CircleAvatar(
//           radius: 80.0,
//           backgroundImage: AssetImage('assets/images/profile.jpeg'),
          
//         ),
//         Positioned(
//           bottom: 20.0,
//           right: 20.0,
//           child: InkWell(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (builder) => bottomSheet(context),
//               );
//             },
//             child: Icon(
//               Icons.camera_alt,
//               color: Colors.teal,
//               size: 28.0,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget bottomSheet(BuildContext context) {
  
//   return Container(
//     height: 100.0,
//     width: MediaQuery.of(context).size.width,
//     margin: EdgeInsets.symmetric(
//       horizontal: 20.0,
//       vertical: 20.0,
//     ),
//     child: Column(
//       children: <Widget>[
//         Text(
//           "Choose Profile photo",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//         SizedBox(
//           height: 20.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton.icon(
//               icon: Icon(Icons.camera),
//               onPressed: () {
//                 takePhoto(ImageSource.camera);
//               },
//               label: Text("Camera"),
//             ),
//             ElevatedButton.icon(
//               icon: Icon(Icons.image),
//               onPressed: () {
//                 takePhoto(ImageSource.gallery);
//               },
//               label: Text("Gallery"),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Future takePhto () async