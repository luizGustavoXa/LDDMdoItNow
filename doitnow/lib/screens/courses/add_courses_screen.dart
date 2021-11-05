import 'package:doitnow/models/course_model.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';

class AddCoursesScreen extends StatelessWidget {

  AddCoursesScreen({
   this.model
  }) {
    if(model != null){
      this._nameController.text = model?.name ?? '';
      this._timeController.text = model?.time ?? '';
    }
  }

  final CourseModel? model;

  final _nameController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildTitle(context),
          SizedBox(height: 10),
          _buildTextField(
            label: 'Nome', 
            controller: this._nameController,
          ),
          SizedBox(height: 20),
          _buildTextField(
            label: 'Periodo', 
            controller: this._timeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
            ],
          ),
          SizedBox(height: 30),
          _buildButton(context),
        ],
      ),
    );
  }

  List<Widget> _buildTitle(context) {
    return [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: CustomColors.azul,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Adicionar curso',
        style: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ];
  }

  Widget _buildTextField({
    required String? label,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.words,
    Function(String)? onChanged,
  }) {
    return TextField(
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildButton(context){
    return ButtonPlus(
      radius: RadiusPlus.all(30),
      color: CustomColors.azul,
      splashColor: Colors.white.withOpacity(.7),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      height: 60,
      width: double.infinity,
      child: TextPlus(
        'Adicionar',
        color: Colors.white,
        fontSize: 20,
      ),
      onPressed: () {
        _handleUpdateCourses(context);
      },
    );
  }

  bool  _validateButton()=>
    this._nameController.text.isNotEmpty && 
    this._timeController.text.isNotEmpty;

  _handleUpdateCourses(context) {

    if(_validateButton()){

      if(this.model == null ){
        Navigator.of(context).pop(
          CourseModel(
            name: this._nameController.text,
            time: this._timeController.text,
          )
        );
        
      } else {
        model!.name = this._nameController.text;
        model!.time = this._timeController.text;

        Navigator.of(context).pop(
          null
        );
      }
    }
  }
}