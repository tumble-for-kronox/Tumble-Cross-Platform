import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String programName;
  final String programSubtitle;
  final String schoolName;
  final AsyncCallback onTap;

  const ProgramCard(
      {super.key,
      required this.schoolName,
      required this.programName,
      required this.programSubtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          width: double.infinity,
          height: 150,
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all<Color>(Colors.grey.shade200),
              foregroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface),
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
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    direction: Axis.horizontal, // main axis (rows or columns)
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
