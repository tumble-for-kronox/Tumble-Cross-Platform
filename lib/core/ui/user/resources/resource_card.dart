import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';

class ResourceCard extends StatelessWidget {
  final ResourceModel resource;

  const ResourceCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 1))],
      ),
      child: MaterialButton(
        onPressed: () {
          // This will update the current loaded resource to the full one once it's fetched
          context.read<ResourceCubit>().getResourceAvailabilities(
                context.read<AuthCubit>().state.userSession!,
                context.read<AuthCubit>().setUserSession,
                context.read<AuthCubit>().logout,
                resource.id,
                context.read<ResourceCubit>().state.chosenDate,
              );

          /// Set the current loaded resource to the resource with just name
          /// as it's accessed in chosenResource page in the top section.
          context.read<ResourceCubit>().setLoadedResource(resource);
          Navigator.of(context).pushNamed('/chosenResource');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          resource.name.trim(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17),
        ),
      ),
    );
  }
}
