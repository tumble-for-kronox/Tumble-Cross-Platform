import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';

class ModalInfoRow extends StatelessWidget {
  final List<Location>? locations;
  final List<Teacher>? teachers;
  final Icon icon;
  final String title;
  final String? subtitle;
  const ModalInfoRow({
    super.key,
    this.locations,
    this.subtitle,
    this.teachers,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.capitalize(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.9),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  (() {
                    if (locations != null) {
                      return locations!.isNotEmpty
                          ? locations!.map((location) => location.id).join(', ')
                          : RuntimeErrorType.missingLocations();
                    }
                    if (teachers != null) {
                      return teachers!.isNotEmpty || teachers!.every((teacher) => teacher.firstName.isEmpty)
                          ? teachers!.map((teacher) => '${teacher.firstName} ${teacher.lastName}').join(', ')
                          : RuntimeErrorType.missingTeachers();
                    }
                    return subtitle!;
                  })(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
