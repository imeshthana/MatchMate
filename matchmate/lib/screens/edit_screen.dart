import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matchmate/components/appbar2.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/components/reusable_card.dart';
import 'package:matchmate/components/textfield.dart';
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
import 'package:matchmate/screens/user_profile.dart';

enum Gender {
  male,
  female,
}

late User? loggedInUser;
final _fireStore = FirebaseFirestore.instance;

class EditProfile extends StatefulWidget {
  static String id = 'edit_screen';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController preferenceController = TextEditingController();
  Gender? selectedGender;
  int age = 0;
  File? _image;
  String? imageUrl;
  String? profileImageUrl;

  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();

  List<String> preferences = [];
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

  String finalTextToBeDisplayed = '';

  @override
  void initState() {
    getCurrentUser();
    getCountries();
    getStates();
    getUserData();
    super.initState();
  }

  void addPreference() {
    String newPreference = preferenceController.text.toLowerCase();
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

  void getUserData() async {
    loggedInUser = _auth.currentUser!;
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('profiles').doc(loggedInUser?.email).get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    setState(() {
      firstnameController.text = userData['firstname'];
      lastnameController.text = userData['lastname'];
      // selectedGender = Gender.values[userData['gender']];
      age = (userData['age'] ?? 0) as int;
      bioController.text = userData['bio'];
      occupationController.text = userData['occupation'];
      // selectedState = userData['state'];
      // selectedCountry = userData['country'];
      preferences = List<String>.from(userData['preferences'] ?? []);
      profileImageUrl = userData['image'] ?? '';
    });
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
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Edit Your Profile",
                style: TextStyle(
                  color: Color.fromRGBO(36, 20, 104, 0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ReusableTextField(
                null, false, firstnameController, "First Name", null),
            const SizedBox(height: 20),
            ReusableTextField(
                null, false, lastnameController, "Last Name", null),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Age',
                  style: textStyle,
                ),
                Container(
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            age--;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            age.toString(),
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            age++;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Change Your Occupation",
                style: textStyle,
              ),
            ),
            const SizedBox(height: 10),
            ReusableTextField(null, false, occupationController,
                "You are a 'Developer' etc.", null),
            const SizedBox(height: 20),
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
                          border:
                              GradientBoxBorder(gradient: gradient, width: 2.5),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: selectedCountry,
                            underline: Container(),
                            menuMaxHeight: 350,
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
                          menuMaxHeight: 350,
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
            const SizedBox(height: 30),
            Text(
              'Change Your Bio',
              style: textStyle,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
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
            const SizedBox(height: 20),
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
                        hintText: 'Change Preferences',
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
                              backgroundColor: Color.fromRGBO(199, 0, 57, 0.8),
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
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Change Your Profile Picture",
                style: textStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ImagePickerWidget(
              onImageSelected: (File image) {
                _image = image;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Center(
                child: MainButton(
              text: 'Save Changes',
              onPress: () async {
                var imageName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                var storageRef =
                    FirebaseStorage.instance.ref().child('$imageName.jpg');
                var uploadTask = storageRef.putFile(_image!);
                var downloadUrl = await (await uploadTask).ref.getDownloadURL();

                setState(() {
                  imageUrl = downloadUrl.toString();
                });

                await _fireStore
                    .collection('profiles')
                    .doc(loggedInUser?.email)
                    .update({
                  'firstname': firstnameController.text,
                  'lastname': lastnameController.text,
                  'age': age,
                  'occupation': occupationController.text,
                  'country': selectedCountry,
                  'state': selectedState,
                  'bio': bioController.text,
                  'preferences': preferences,
                  'image': imageUrl,
                });

                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Center(
                      child: Text('Changes are saved succesfully!',
                          textAlign: TextAlign.center, style: textStyle),
                    ),
                  ),
                );
              },
            )),
            SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
