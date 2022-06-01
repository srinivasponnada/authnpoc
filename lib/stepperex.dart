import 'dart:io';
import 'package:authnpoc/takepicture.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

void main() {
  runApp(const stepperex());
}

class stepperex extends StatefulWidget {
  const stepperex({Key? key}) : super(key: key);
  @override
  _StepperExState createState() => _StepperExState();
}

class _StepperExState extends State<stepperex> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  switchStepType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Example'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              //physics: ClampingScrollPhysics(),
              steps: _stepper(),
              type: stepperType,
              currentStep: this._currentStep,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    //Logic
                    print('complete');
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.swap_horizontal_circle),
        onPressed: switchStepType,
      ),
    );
  }

  void getImageFromCamera() async {
    File? imageFile;
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
          key: 'ExampleKey4',
          onProgress: (progress) {
            print("Fraction completed: " + progress.getFractionCompleted().toString());
          }
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
          title: Text('Name'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
            ],
          ),
          isActive: _currentStep >= 0,
          state: StepState.complete),
      Step(
          title: Text('Email'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recovery Email'),
              ),
            ],
          ),
          isActive: _currentStep >= 1,
          state: StepState.disabled),
      Step(
          title: Text('Mobile No.'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile No.'),
              ),
              TextFormField(
                decoration:
                InputDecoration(labelText: 'Alternative Mobile No.'),
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.editing),
      Step(
          title: Text('Address'),
          content: Column(
            children: <Widget>[
              OutlinedButton(onPressed: getImageFromCamera, child: Text('Take a Picture'))
              //takepicture(),
              /*TextFormField(
                decoration: InputDecoration(labelText: 'Address 1'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address 2'),
              ),*/
            ],
          ),
          isActive: _currentStep >= 3,
          state: StepState.error),
      Step(
          title: Text('Password'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
          isActive: _currentStep >= 4,
          state: StepState.indexed),
    ];
    return _steps;
  }
}