import 'package:doitnow/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class SubjectCard extends StatelessWidget {

  final SubjectModel subjectModel;

  SubjectCard({
    required this.subjectModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(.4)
          )
        )
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPlus(
                  subjectModel.curso!.capitalizeFirstWord,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  textOverflow: TextOverflow.ellipsis,
                ),
                TextPlus(
                  subjectModel.disciplina!.capitalizeFirstWord,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: 15,
                ),
              ],
            ),
          ),
          TextPlus(
            subjectModel.nota,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}