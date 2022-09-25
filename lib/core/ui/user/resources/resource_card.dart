import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/tumble_chosen_resource_page.dart';

import '../../../navigation/app_navigator.dart';

class ResourceCard extends StatelessWidget {
  final ResourceModel resource;

  const ResourceCard({Key? key, required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
      ),
      child: MaterialButton(
        onPressed: () {
          context
              .read<UserEventCubit>()
              .getResourceAvailabilities(context.read<AuthCubit>(), resource.id, DateTime.now())
              .then((_) {
            if (context.read<UserEventCubit>().state.resourcePageErrorMessage != null) {
              showScaffoldMessage(context, context.read<UserEventCubit>().state.resourcePageErrorMessage!);
            }
          });
          Navigator.of(context).pushNamed('/chosenResource');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          resource.name.trim(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
