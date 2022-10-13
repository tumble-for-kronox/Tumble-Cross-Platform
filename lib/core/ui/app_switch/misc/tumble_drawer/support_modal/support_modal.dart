import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/drawer_state.dart';
import 'package:tumble/core/ui/cubit/support_modal_state.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_details_modal_base.dart';
import 'package:tumble/core/ui/tumble_button.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class BugReportModal extends StatefulWidget {
  const BugReportModal({Key? key}) : super(key: key);

  @override
  State<BugReportModal> createState() => _BugReportModalState();

  static void showBugReportModal(BuildContext context, DrawerCubit cubit) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) => const BugReportModal());
  }
}

class _BugReportModalState extends State<BugReportModal> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SupportModalCubit(), child: const SupportModalBuilder());
  }
}

class SupportModalBuilder extends StatefulWidget {
  const SupportModalBuilder({Key? key}) : super(key: key);

  @override
  State<SupportModalBuilder> createState() => _SupportModalBuilderState();
}

class _SupportModalBuilderState extends State<SupportModalBuilder> {
  @override
  Widget build(BuildContext context) => BlocBuilder<SupportModalCubit, SupportModalState>(
        builder: (context, state) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              height:
                  !state.focused ? MediaQuery.of(context).size.height - 400 : MediaQuery.of(context).size.height - 200,
              child: SupportModalShell(
                  subjectValidator: (_) {
                    return state.isSubjectValid ? null : S.supportModal.subjectTooShort();
                  },
                  bodyValidator: (_) {
                    return state.isBodyValid ? null : S.supportModal.bodyTooShort();
                  },
                  subjectController: context.read<SupportModalCubit>().subjectController,
                  bodyController: context.read<SupportModalCubit>().bodyController,
                  onPressed: () async {
                    if (state.isBodyValid && state.isSubjectValid) {
                      context.read<SupportModalCubit>().setLoading();
                      context.read<SupportModalCubit>().sendBugReport();
                    }
                  },
                  status: state.status!),
            ),
          );
        },
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
  Widget build(BuildContext context) => TumbleDetailsModalBase(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: (status == SupportModalStatus.INITIAL || status == SupportModalStatus.ERROR)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (status == SupportModalStatus.INITIAL) _buildTextFormFields(context),
              Center(
                  child: FractionallySizedBox(
                widthFactor: (status == SupportModalStatus.INITIAL) ? .6 : .9,
                child: () {
                  switch (status) {
                    case SupportModalStatus.INITIAL:
                      return TumbleButton(
                        onPressed: onPressed,
                        prefixIcon: CupertinoIcons.paperplane,
                        text: S.general.send(),
                        loading: false,
                      );
                    case SupportModalStatus.LOADING:
                      return const TumbleLoading();
                    case SupportModalStatus.SENT:
                      return TumbleButton(
                        onPressed: () {},
                        prefixIcon: CupertinoIcons.check_mark_circled,
                        text: S.supportModal.sendSucces(),
                        loading: false,
                      );
                    case SupportModalStatus.ERROR:
                      return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColors.orangePrimary,
                        ),
                        child: Text(
                          S.supportModal.sendFail(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                  }
                }(),
              )),
            ],
          ),
        ),
        title: S.supportModal.title(),
        barColor: Theme.of(context).colorScheme.primary,
      );

  _buildTextFormFields(BuildContext context) => Column(
        children: [
          TextFormField(
            focusNode: context.read<SupportModalCubit>().focusNodeSubject,
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
            focusNode: context.read<SupportModalCubit>().focusNodeBody,
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
