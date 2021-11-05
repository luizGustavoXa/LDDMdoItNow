import 'dart:convert';

import 'package:doitnow/models/subject_model.dart';
import 'package:doitnow/screens/subjects/add_subject_screen.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:doitnow/widgets/drawer/drawer.dart';
import 'package:doitnow/widgets/subject/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SubjectsScreen extends StatefulWidget {

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {

  List<SubjectModel> _subjectsList = [];
  static const storagePath = 'subjects';

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Do It Now'),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          TextPlus(
            'Minhas disciplinas',
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 16,
          ),
          ...this._subjectsList.map((e) => 
            InkWell(
              child: SubjectCard(subjectModel: e),
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                    AddSubjectScreen(
                      subjectModel: e,
                    )
                  )
                );
                setState(() {});
                try {
                  await localStoragePlus.delete(storagePath);
                  await localStoragePlus.write(
                    storagePath,
                    json.encode(this._subjectsList)
                  );
                } catch (e) {
                  print(e);
                }
              },
            )
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(context){
    return FloatingActionButton(
      onPressed: () async {

         SubjectModel? model = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
            AddSubjectScreen()
          )
        );

        if(model != null){
          setState(() {
            this._subjectsList.add(model);
          });

          try {
            await localStoragePlus.delete(storagePath);
            await localStoragePlus.write(
              storagePath,
              json.encode(this._subjectsList)
            );
          } catch (e) {
            print(e);
          }
        }
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: CustomColors.azul,
    );
  }

  _loadSubjects() async{
    final list = await localStoragePlus.read(storagePath);
    if(list == null) return;
    setState(() {
      this._subjectsList.addAll(SubjectModel.fromMapList(json.decode(list))); 
    });
  }
}