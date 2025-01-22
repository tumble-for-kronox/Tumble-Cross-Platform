import 'package:flutter/cupertino.dart';

class ContributorsSection extends StatelessWidget {
  final String sessionTitle;
  final List<String> contributors;

  const ContributorsSection({super.key, required this.sessionTitle, required this.contributors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sessionTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contributors
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      child: Text(e),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
