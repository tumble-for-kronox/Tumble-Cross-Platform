import 'package:flutter/cupertino.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view/week_list_view.dart';

class TumbleWeekView extends StatefulWidget {
  final String? scheduleId;
  final List<Week>? listOfWeeks;
  const TumbleWeekView({Key? key, this.scheduleId, this.listOfWeeks})
      : super(key: key);

  @override
  State<TumbleWeekView> createState() => _TumbleWeekViewState();
}

class _TumbleWeekViewState extends State<TumbleWeekView> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: PageView.builder(
              itemCount: widget.listOfWeeks!.length,
              itemBuilder: (context, index) {
                return TumbleWeekPageContainer(
                  scheduleId: widget.scheduleId!,
                  week: widget.listOfWeeks![index],
                );
              })),
    ]);
  }
}
