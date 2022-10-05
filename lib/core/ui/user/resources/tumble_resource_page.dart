import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/user/resources/resource_card.dart';
import 'package:tumble/core/ui/user/resources/tumble_chosen_resource_page.dart';

import 'cubit/resource_cubit.dart';

class ResourcePage extends StatelessWidget {
  final Future<void> Function()? onSchoolResourcesRefresh;

  const ResourcePage({Key? key, this.onSchoolResourcesRefresh}) : super(key: key);

  Map<String, Widget Function(BuildContext, ResourceState)> _routeBuilders(BuildContext context) {
    return {
      '/': (context, state) => _schoolResourcesList(context, state),
      '/chosenResource': (context, state) => const TumbleChosenResourcePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return Navigator(
          initialRoute: '/',
          onGenerateRoute: (routeSettings) {
            return CupertinoPageRoute(
                builder: (context) => Container(
                      color: Theme.of(context).colorScheme.background,
                      child: routeBuilders[routeSettings.name]!(context, state),
                    ));
          },
        );
      },
    );
  }

  Widget _schoolResourcesList(BuildContext context, ResourceState state) {
    return RefreshIndicator(
      onRefresh: onSchoolResourcesRefresh!,
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: state.schoolResources!
                  .map((e) => Column(children: [
                        ResourceCard(resource: e),
                        const SizedBox(
                          height: 25,
                        )
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
