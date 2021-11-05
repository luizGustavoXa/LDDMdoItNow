import 'package:doitnow/models/subject_model.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';

class AddSubjectScreen extends StatelessWidget {

  AddSubjectScreen({
   this.subjectModel
  }) {
    if(subjectModel != null){
      disciplinaController.text = subjectModel?.disciplina ?? '';
      cursoController.text = subjectModel?.curso ?? '';
      notaController.text = subjectModel?.nota ?? '';
    }
  }

  final SubjectModel? subjectModel;

  final disciplinaController = TextEditingController();
  final cursoController = TextEditingController();
  final notaController = TextEditingController();

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
            label: 'Disciplina', 
            controller: this.disciplinaController,
          ),
          SizedBox(height: 20),
          _buildTextField(
            label: 'Curso', 
            controller: this.cursoController,
          ),
          SizedBox(height: 20),
          _buildTextField(
            label: 'Nota', 
            controller: this.notaController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
            ]
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
        'Adicionar disciplina',
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
        _handleSubject(context);
      },
    );
  }

  bool  _validateButton()=>
    this.disciplinaController.text.isNotEmpty && 
    this.cursoController.text.isNotEmpty &&
    this.notaController.text.isNotEmpty;

  _handleSubject(context) {

    if(_validateButton()){

      if(this.subjectModel == null ){
        Navigator.of(context).pop(
          SubjectModel(
            disciplina: this.disciplinaController.text,
            curso: this.cursoController.text,
            nota: this.notaController.text,
          )
        );
        
      } else {

        subjectModel!.disciplina = this.disciplinaController.text;
        subjectModel!.curso = this.cursoController.text;
        subjectModel!.nota = this.notaController.text;

        Navigator.of(context).pop(
          null
        );
      }
    }
  }
}