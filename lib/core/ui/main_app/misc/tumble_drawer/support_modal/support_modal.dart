import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/support_modal/cubit/support_modal_state.dart';
import 'package:tumble/core/ui/tumble_button.dart';

class SupportModal extends StatefulWidget {
  const SupportModal({Key? key}) : super(key: key);

  @override
  State<SupportModal> createState() => _SupportModalState();

  static void showSupportModal(BuildContext context, DrawerCubit cubit) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) => const SupportModal());
  }
}

class _SupportModalState extends State<SupportModal> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SupportModalCubit(),
        child: const SupportModalBuilder());
  }
}

class SupportModalBuilder extends StatefulWidget {
  const SupportModalBuilder({Key? key}) : super(key: key);

  @override
  State<SupportModalBuilder> createState() => _SupportModalBuilderState();
}

class _SupportModalBuilderState extends State<SupportModalBuilder> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: context.read<SupportModalCubit>().init(),
        builder: (_, snapshot) => SizedBox(
          height: MediaQuery.of(context).size.height - 400,
          child: BlocBuilder<SupportModalCubit, SupportModalState>(
            builder: (context, state) {
              return SupportModalShell(
                  subjectValidator: (_) {
                    return state.isSubjectValid!
                        ? null
                        : 'Subject must be greater than 5 characters';
                  },
                  bodyValidator: (_) {
                    return state.isBodyValid!
                        ? null
                        : 'Body must be greater than 5 characters';
                  },
                  subjectController:
                      context.read<SupportModalCubit>().subjectController,
                  bodyController:
                      context.read<SupportModalCubit>().bodyController,
                  onPressed: () async {
                    if (state.isBodyValid! && state.isSubjectValid!) {
                      context.read<SupportModalCubit>().setLoading();
                      context.read<SupportModalCubit>().sendBugReport();
                    }
                  },
                  status: state.status!);
            },
          ),
        ),
      );
}

typedef BugReportValidator = String? Function(String?)?;

class SupportModalShell extends StatelessWidget {
  final BugReportValidator subjectValidator;
  final BugReportValidator bodyValidator;
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final void Function() onPressed;
  final SupportModalStatus status;

  const SupportModalShell(
      {Key? key,
      required this.subjectValidator,
      required this.bodyValidator,
      required this.subjectController,
      required this.bodyController,
      required this.onPressed,
      required this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 260,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: status == SupportModalStatus.INITIAL
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (status == SupportModalStatus.INITIAL)
                  _buildTextFormFields(),
                Center(
                    child: FractionallySizedBox(
                  widthFactor: .6,
                  child: () {
                    switch (status) {
                      case SupportModalStatus.INITIAL:
                        return TumbleButton(
                          onPressed: onPressed,
                          prefixIcon: CupertinoIcons.paperplane,
                          text: S.general.send(),
                        );
                      case SupportModalStatus.LOADING:
                        return const SpinKitThreeBounce(
                            color: CustomColors.orangePrimary);
                      case SupportModalStatus.SENT:
                        return TumbleButton(
                          onPressed: () {},
                          prefixIcon: CupertinoIcons.check_mark_circled,
                          text: 'Bug report sent!',
                        );
                      case SupportModalStatus.ERROR:
                        const Text(
                            'There was an error with your request. Please try again at a later time');
                        break;
                    }
                  }(),
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                color: CustomColors.orangePrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                S.supportModal.title(),
                style: TextStyle(
                  fontSize: 16,
                  color: CustomColors.orangePrimary.contrastColor(),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      );

  _buildTextFormFields() => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: true,
            validator: subjectValidator,
            controller: subjectController,
            maxLength: 25,
            decoration: InputDecoration(
              labelText: S.supportModal.subjectLabel(),
              labelStyle: const TextStyle(
                fontSize: 14,
                color: CustomColors.orangePrimary,
              ),
              helperText: S.supportModal.subjectHelper(),
              suffixIcon: const Icon(
                CupertinoIcons.ant,
                size: 17,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.orangePrimary),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: true,
            validator: bodyValidator,
            controller: bodyController,
            maxLength: 200,
            decoration: InputDecoration(
              labelText: S.supportModal.bodyLabel(),
              labelStyle: const TextStyle(
                fontSize: 14,
                color: CustomColors.orangePrimary,
              ),
              helperText: S.supportModal.bodyHelper(),
              suffixIcon: const Icon(CupertinoIcons.wrench, size: 17),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.orangePrimary),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
}
