import 'dart:convert';

import 'package:doitnow/models/course_model.dart';
import 'package:doitnow/screens/courses/add_courses_screen.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:doitnow/widgets/courses/course_card.dart';
import 'package:doitnow/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CoursesScreen extends StatefulWidget {

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {

  List<CourseModel> _coursesList = [];
  static const storagePath = 'courses';

  @override
  void initState() {
    super.initState();
    _loadCourses();
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
            'Meus cursos',
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 16,
          ),
          ...this._coursesList.map((element) => 
            InkWell(
              child: CourseCard(model: element),
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                    AddCoursesScreen(
                      model: element,
                    )
                  )
                );
                setState(() {});
                try {
                  await localStoragePlus.delete(storagePath);
                  await localStoragePlus.write(
                    storagePath,
                    json.encode(this._coursesList)
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

         CourseModel? model = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
            AddCoursesScreen()
          )
        );

        if(model != null){
          setState(() {
            this._coursesList.add(model);
          });

          try {
            await localStoragePlus.delete(storagePath);
            await localStoragePlus.write(
              storagePath,
              json.encode(this._coursesList)
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

  _loadCourses() async{
    final list = await localStoragePlus.read(storagePath);
    if(list == null) return;
    setState(() {
      this._coursesList.addAll(CourseModel.fromMapList(json.decode(list))); 
    });
  }
}