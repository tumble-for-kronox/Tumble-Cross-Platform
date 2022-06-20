import 'package:flutter/cupertino.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/week_widget.dart';

class TumbleWeekView extends StatefulWidget {
  final String? scheduleId;
  final List<Week>? weekView;
  const TumbleWeekView({Key? key, this.scheduleId, this.weekView})
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
              itemCount: widget.weekView!.length,
              itemBuilder: (context, snapshot) {
                return WeekWidget();
              })),
    ]);
  }
}
