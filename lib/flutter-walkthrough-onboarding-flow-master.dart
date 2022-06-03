import 'package:flutter/material.dart';
import 'package:authnpoc/on_boarding.dart';

void main(){
  runApp(const flutter_walkthrough_onboarding_flow_master());
}

class flutter_walkthrough_onboarding_flow_master extends StatefulWidget {

  const flutter_walkthrough_onboarding_flow_master({Key? key}) : super(key: key);

  @override
  _flutter_walkthrough_onboarding_flow_master createState() => _flutter_walkthrough_onboarding_flow_master();
}

class _flutter_walkthrough_onboarding_flow_master extends State<flutter_walkthrough_onboarding_flow_master> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoarding(),
    );
  }
}