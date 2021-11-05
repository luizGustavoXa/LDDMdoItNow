import 'package:doitnow/controllers/drawer_controller.dart';
import 'package:doitnow/screens/courses/courses_screen.dart';
import 'package:doitnow/screens/subjects/subjects_screen.dart';
import 'package:doitnow/screens/tasks/todo_list_screen.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:get_it/get_it.dart';

class CustomDrawer extends StatelessWidget {

  final _controller = GetIt.I<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            _buildUser(),
            SizedBox(height: 24,),
            _buildLine(
              text: 'Cursos',
              icon: Icons.book,
              index: CustomDrawerController.cursosIndex,
              onTap:(){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CoursesScreen())
                );
                _controller.setCurrentIndex(CustomDrawerController.cursosIndex);
              }
            ),
            Divider(),
            _buildLine(
              text: 'Disciplinas',
              icon: Icons.library_books_sharp,
              index: CustomDrawerController.disciplinaIndex,
              onTap:(){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SubjectsScreen())
                );
                _controller.setCurrentIndex(CustomDrawerController.disciplinaIndex);
              }
            ),
            Divider(),
            _buildLine(
              text: 'Tarefas',
              icon: Icons.task_rounded,
              index: CustomDrawerController.tarefasIndex,
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TodoListScreen()),
                );
                _controller.setCurrentIndex(CustomDrawerController.tarefasIndex);
              }
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildUser(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: CustomColors.azul,
            size: 48,
          ),
          SizedBox(width: 16,),
          TextPlus(
            'User',
            color: CustomColors.azul,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildLine({
    required String text, 
    required IconData icon, 
    required int index,
    Function()? onTap
  }){
    final color = index == _controller.currentIndex ? CustomColors.azul : Colors.black;

    return ContainerPlus(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(width: 16,),
          TextPlus(
            text,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }
}