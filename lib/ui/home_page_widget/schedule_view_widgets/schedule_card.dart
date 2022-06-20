import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String course;
  final String teacher;
  final String location;
  final String color;
  final DateTime timeStart;
  final DateTime timeEnd;
  final VoidCallback onTap;

  const ScheduleCard({
    Key? key,
    required this.title,
    required this.course,
    required this.teacher,
    required this.location,
    required this.color,
    required this.timeStart,
    required this.timeEnd,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 9, left: 20, right: 20),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ]),
              child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onTap,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.85,
                            alignment: Alignment.topLeft,
                            child: () {
                              if (title.length >= 50) {
                                return Text('${title.substring(0, 46)}...',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                    ));
                              } else {
                                return Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                            }(),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: () {
                                      if (course.length >= 60) {
                                        return Text(
                                            course.substring(0, 56) + '...',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ));
                                      } else {
                                        return Text(course,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ));
                                      }
                                    }()),
                                () {
                                  if (location == "") return Container();
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 10),
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 3),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          location.replaceAll(" ", "\n"),
                                          maxLines: 2,
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }(),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    '${DateFormat.Hm().format(timeStart)} - ${DateFormat.Hm().format(timeEnd)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
            Container(
                margin: const EdgeInsets.only(top: 9, right: 20),
                alignment: Alignment.topRight,
                child: Image(
                    width: 50,
                    height: 50,
                    image: const AssetImage("assets/images/cardBanner.png"),
                    color: Color(int.parse("ff${color.replaceAll("#", "")}",
                        radix: 16))))
          ],
        ));
  }
}
