import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matchmate/components/message_bubble.dart';
import 'package:matchmate/screens/profile.dart';
import 'package:matchmate/screens/favourites_screen.dart';
import '../components/constants.dart';
import 'package:crypto/crypto.dart';

late User? loggedInUser;
final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  ChatScreen({required this.userEmail});
  final String userEmail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String favouritesLastName = '';
  String favouritesFirstName = '';
  String? favouritesImage;
  String? favoriteUserEmail;

  File? _image;
  String? imageUrl;
  Uint8List? image;
  File? selectedImage;

  late String messageText;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    fetchFavoritesName(widget.userEmail);
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void fetchFavoritesName(String useremail) async {
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('profiles').doc(useremail).get();

    setState(() {
      favouritesFirstName = userSnapshot['firstname'];
      favouritesLastName = userSnapshot['lastname'];
      favouritesImage = userSnapshot['image'];
    });
  }

  String createUniqueID(String str1, String str2) {
    String concatenated = '$str1|$str2';

    var bytes = utf8.encode(concatenated);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  String createChatDocumentID(String userEmail1, String userEmail2) {
    List<String> emails = [userEmail1, userEmail2];
    emails.sort();
    return createUniqueID(emails[0], emails[1]);
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    // Navigator.of(context).pop();
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    // Navigator.of(context).pop();
  }

  void _setImage(File imageFile) {
    setState(() {
      selectedImage = imageFile;
      image = imageFile.readAsBytesSync();
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Image.file(selectedImage!),
          actions: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () async {
                        var imageName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        var storageRef = FirebaseStorage.instance
                            .ref()
                            .child('$imageName.jpg');
                        var uploadTask = storageRef.putFile(selectedImage!);
                        var downloadUrl =
                            await (await uploadTask).ref.getDownloadURL();

                        setState(() {
                          imageUrl = downloadUrl.toString();
                        });

                        _fireStore
                            .collection('messages')
                            .doc(createChatDocumentID(
                                loggedInUser!.email!, widget.userEmail))
                            .collection('messages')
                            .add({
                          'text': imageUrl,
                          'sender': loggedInUser?.email,
                          'receiver': widget.userEmail,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void deleteMessage(String messageId) async {
    await _fireStore
        .collection('messages')
        .doc(createChatDocumentID(loggedInUser!.email!, widget.userEmail))
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: Color.fromRGBO(199, 0, 57, 0.8),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: gradient),
        ),
        title: GestureDetector(
          onTap: () {
            Profile(
              userEmail: widget.userEmail,
            );
          },
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('$favouritesImage'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '$favouritesFirstName $favouritesLastName',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.5),
                      BlendMode.dstATop,
                    ),
                    child: Image.asset('assets/logo.jpg'),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _fireStore
                      .collection('messages')
                      .doc(createChatDocumentID(
                          loggedInUser!.email!, widget.userEmail))
                      .collection('messages')
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        color: Colors.transparent,
                        strokeWidth: 4,
                      );
                    }

                    final messages = snapshot.data?.docs.reversed;
                    List<MessageBubble> messageBubbles = [];
                    for (QueryDocumentSnapshot<Map<String, dynamic>> message
                        in messages ?? []) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];

                      final currentUser = loggedInUser?.email;

                      final messageBubble = MessageBubble(
                        messageId: message.id,
                        sender: messageSender,
                        text: messageText,
                        isMe: currentUser == messageSender,
                        deleteMessage: () => deleteMessage(message.id),
                      );
                      messageBubbles.add(messageBubble);
                    }

                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: messageBubbles,
                      ),
                    );
                  }),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(36, 20, 104, 0.6),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kColor3, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: GradientOutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            gradient: LinearGradient(
                              colors: [kColor1, kColor2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.clamp,
                            ),
                            width: 2.0)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera),
                    color: Colors.white,
                    onPressed: () {
                      bottomSheet(context);
                      messageTextController.clear();
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () {
                      _fireStore
                          .collection('messages')
                          .doc(createChatDocumentID(
                              loggedInUser!.email!, widget.userEmail))
                          .collection('messages')
                          .add({
                        'text': messageTextController.text,
                        'sender': loggedInUser?.email,
                        'receiver': widget.userEmail,
                        'timestamp': FieldValue.serverTimestamp(),
                        'image': '',
                      });

                      messageTextController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
