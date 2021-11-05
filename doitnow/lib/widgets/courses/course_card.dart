import 'package:doitnow/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class CourseCard extends StatelessWidget {

  final CourseModel model;

  CourseCard({
    required this.model
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
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextPlus(
              model.name.capitalizeFirstWord,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          TextPlus(
            model.time + 'º',
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}