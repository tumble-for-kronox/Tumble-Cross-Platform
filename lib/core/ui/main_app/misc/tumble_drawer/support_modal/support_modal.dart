import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/theme/data/colors.dart';
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
      child: BlocBuilder<SupportModalCubit, SupportModalState>(
        builder: (context, state) {
          return FutureBuilder(
            future: context.read<SupportModalCubit>().init(),
            builder: (context, snapshot) => SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 260,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 50),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autocorrect: true,
                            validator: (_) {
                              return state.isBodyValid!
                                  ? null
                                  : 'Subject must be greater than 5 characters';
                            },
                            controller: context
                                .read<SupportModalCubit>()
                                .subjectController,
                            maxLength: 25,
                            decoration: const InputDecoration(
                              labelText: 'Type of issue',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: CustomColors.orangePrimary,
                              ),
                              helperText:
                                  'Summarize your issue in a short title',
                              suffixIcon: Icon(
                                CupertinoIcons.ant,
                                size: 17,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.orangePrimary),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autocorrect: true,
                            validator: (_) {
                              return state.isSubjectValid!
                                  ? null
                                  : 'Body must be greater than 5 characters';
                            },
                            controller: context
                                .read<SupportModalCubit>()
                                .bodyController,
                            maxLength: 200,
                            decoration: const InputDecoration(
                              labelText: 'Explain your issue',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: CustomColors.orangePrimary,
                              ),
                              helperText:
                                  'Explain your issue in a bit more detail for us',
                              suffixIcon: Icon(CupertinoIcons.wrench, size: 17),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.orangePrimary),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                              child: FractionallySizedBox(
                            widthFactor: .6,
                            child: TumbleButton(
                              onPressed: () {},
                              prefixIcon: CupertinoIcons.paperplane,
                              text: 'Send',
                            ),
                          )),
                        ],
                      ),
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
                        "SUPPORT",
                        style: TextStyle(
                          fontSize: 16,
                          color: CustomColors.orangePrimary.contrastColor(),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
