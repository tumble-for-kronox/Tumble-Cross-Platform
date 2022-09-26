import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/resource_cubit.dart';

class RoomCard extends StatelessWidget {
  final String roomId;
  final String? selectedRoomId;

  const RoomCard({Key? key, required this.roomId, required this.selectedRoomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
          ),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.read<ResourceCubit>().changeSelectedLocationId(roomId),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              roomId,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        selectedRoomId == roomId
            ? Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Container(),
      ],
    );
  }
}
