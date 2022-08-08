import 'package:flutter/material.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';

class ModalInfoRow extends StatelessWidget {
  final List<Location>? locations;
  final List<Teacher>? teachers;
  final Icon icon;
  final String title;
  final String? subtitle;
  const ModalInfoRow({
    Key? key,
    this.locations,
    this.subtitle,
    this.teachers,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.8),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              (() {
                if (locations != null) {
                  return locations!.isNotEmpty
                      ? locations!.map((location) => location.id).join(', ')
                      : RuntimeErrorType.missingLocations;
                }
                if (teachers != null) {
                  return teachers!.isNotEmpty
                      ? teachers!
                          .map((teacher) =>
                              '${teacher.firstName} ${teacher.lastName}')
                          .join(', ')
                      : RuntimeErrorType.missingLocations;
                }
                return subtitle!.length < 38
                    ? subtitle!
                    : '${subtitle!.substring(0, 38)}..';
              })(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
