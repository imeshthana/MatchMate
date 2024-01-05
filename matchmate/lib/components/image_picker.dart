import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            _image != null
                ? CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white60,
                    backgroundImage: MemoryImage(_image!),
                  )
                : CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white60,
                    backgroundImage: AssetImage("assets/profile.jpeg"),
                  ),
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  bottomSheet(context);
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    Navigator.of(context).pop(); // close the modal sheet
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    Navigator.of(context).pop(); // close the modal sheet
  }

  void _setImage(File imageFile) {
    setState(() {
      selectedImage = imageFile;
      _image = imageFile.readAsBytesSync();
    });
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blueGrey,
      context: context,
      builder: (builder) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.image),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt),
                      Text("Camera"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
