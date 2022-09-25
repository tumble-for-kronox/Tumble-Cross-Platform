import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';

class TumbleChosenResourcePage extends StatelessWidget {
  const TumbleChosenResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEventCubit, UserEventState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Expanded(flex: 1, child: _upperSection(context, state)),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: _lowerSection(context, state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _upperSection(BuildContext context, UserEventState state) {
    switch (state.resourcePageStatus) {
      case ResourcePageStatus.LOADING:
        return Container();
      case ResourcePageStatus.LOADED:
        return _upperSectionLoaded(context, state);
      case ResourcePageStatus.ERROR:
      case ResourcePageStatus.INITIAL:
        return Container();
    }
  }

  Widget _lowerSection(BuildContext context, UserEventState state) {
    switch (state.resourcePageStatus) {
      case ResourcePageStatus.LOADING:
        return const TumbleLoading();
      case ResourcePageStatus.LOADED:
        return Container();
      case ResourcePageStatus.ERROR:
      case ResourcePageStatus.INITIAL:
        return Container();
    }
  }

  Widget _upperSectionLoaded(BuildContext context, UserEventState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.currentLoadedResource!.name,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                DateFormat("MMMM d, y").format(DateTime.now()),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                CupertinoIcons.calendar,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
