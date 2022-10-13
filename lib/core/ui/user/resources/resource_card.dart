import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';

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
          context.read<ResourceCubit>().getResourceAvailabilities(
              context.read<AuthCubit>().state.userSession!.sessionToken,
              context.read<AuthCubit>().login,
              context.read<AuthCubit>().logout,
              resource.id,
              context.read<ResourceCubit>().state.chosenDate);
          context.read<ResourceCubit>().setLoadedResource(resource);
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
