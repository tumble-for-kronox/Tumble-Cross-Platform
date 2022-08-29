import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String programName;
  final String programSubtitle;
  final String schoolName;
  final AsyncCallback onTap;

  const ProgramCard(
      {Key? key,
      required this.schoolName,
      required this.programName,
      required this.programSubtitle,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          width: double.infinity,
          height: 125,
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade200),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.onBackground),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      programSubtitle.trim(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        programName.split(RegExp(r'\s-')).first,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        schoolName,
                        textAlign: TextAlign.right,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          height: 0,
          thickness: 1,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
