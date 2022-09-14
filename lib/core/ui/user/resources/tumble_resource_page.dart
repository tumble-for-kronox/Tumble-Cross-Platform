import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/resource_card.dart';
import 'package:tumble/core/ui/user/resources/resource_card_containers.dart';
import 'package:tumble/core/ui/user/resources/resource_room_card.dart';
import 'package:tumble/core/ui/user/resources/resource_time_stamp_card.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEventCubit, UserEventState>(
      builder: (context, state) {
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
      },
    );
  }
}
