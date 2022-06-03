import 'dart:core';
import 'package:flutter/material.dart';

import 'job.dart';

class JobList extends StatefulWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> joblist = <Job>[];
  int count = 0;
  bool isLoading = true;
  bool isDark = false;
  bool isListView = true;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Job List'),
        ),
        body: getJobListView(),
        //body: getNoteListView(),
    );
  }

  ListView getJobListView() {
    return ListView.builder(
        itemBuilder: (context, position){
          return Card(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4.0,
              ),
            ),
            color: Colors.purple,
            elevation: 4.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                NetworkImage('https://learncodeonline.in/mascot.png'),
              ),
              title: Text(
                '123456',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                'joblist[position].description',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        }
    );


  }

  void updateListView() {

    Job j1 = new Job(646031,'62 Church Road, Johns Creek GA', '7.0 Miles', 'Mar 27, 2002 - 01.38PM', 1);

    List<Job> jl = <Job>[];
    jl.add(j1);

    setState(() {
      joblist = jl;
      count = jl.length;
      isLoading = false;
    });
  }
}

