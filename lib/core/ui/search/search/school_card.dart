import 'package:flutter/material.dart';
import 'package:tumble/core/helpers/school_enum.dart';

class SchoolCard extends StatelessWidget {
  final SchoolEnum schoolId;
  final String schoolName;
  final String schoolLogo;
  final VoidCallback selectSchool;

  const SchoolCard({
    Key? key,
    required this.selectSchool,
    required this.schoolId,
    required this.schoolName,
    required this.schoolLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ]),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: selectSchool,
        child: Row(
          children: [
            const SizedBox(
              width: 5,
              height: 100,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                width: 90,
                image: AssetImage(schoolLogo),
              ),
            ),
            Expanded(
              child: Text(
                schoolName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
