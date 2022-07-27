import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String programName;
  final String programId;
  final VoidCallback onTap;

  const ProgramCard(
      {Key? key,
      required this.programName,
      required this.programId,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          width: double.infinity,
          height: 110,
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
                  Text(
                    programId,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    programName,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w200,
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
