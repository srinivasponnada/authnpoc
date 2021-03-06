import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const takepicture());
}

class takepicture extends StatelessWidget {
  const takepicture({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? imageFile;

  void getImageFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);

    setState(() {
      imageFile = File(pickedFile!.path);
    });

    final exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File(tempDir.path + '/example.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    await exampleFile.writeAsBytes(imageFile!.readAsBytesSync());

    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: 'ExampleKey2',
          onProgress: (progress) {
            print("Fraction completed: " + progress.getFractionCompleted().toString());
          }
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Picker"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          imageFile != null
              ? Image.file(imageFile!)
              : Icon(
            Icons.camera,
            color: Colors.black,
            size: MediaQuery.of(context).size.width * .5,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                getImageFromCamera();
              },
              child: const Text('Capture an Image'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                  textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 16))),
            ),
          )
        ],
      ),
    );
  }
}
