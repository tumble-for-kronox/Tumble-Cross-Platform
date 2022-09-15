import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/resource_card.dart';
import 'package:tumble/core/ui/user/resources/resource_card_containers.dart';
import 'package:tumble/core/ui/user/resources/resource_room_card.dart';
import 'package:tumble/core/ui/user/resources/resource_time_stamp_card.dart';
import 'package:tumble/core/ui/user/resources/tumble_chosen_resource_page.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({Key? key}) : super(key: key);

  Map<String, Widget Function(BuildContext, UserEventState)> _routeBuilders(BuildContext context) {
    return {
      '/': (context, state) => _schoolResourcesList(state),
      '/chosenResource': (context, state) => const TumbleChosenResourcePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return BlocBuilder<UserEventCubit, UserEventState>(
      builder: (context, state) {
        return Scaffold(
          body: Navigator(
            initialRoute: '/',
            onGenerateRoute: (routeSettings) {
              return CupertinoPageRoute(builder: (context) => routeBuilders[routeSettings.name]!(context, state));
            },
          ),
        );
      },
    );
  }

  Widget _schoolResourcesList(UserEventState state) {
    return SafeArea(
      child: Padding(
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
    );
  }
}
