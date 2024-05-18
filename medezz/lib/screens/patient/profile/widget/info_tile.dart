import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.tileName,
    required this.content,
    required this.icon,
  });

  final String tileName;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 60,
      width: double.infinity,
      color: Colors.grey,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              tileName,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Icon(icon, color: CustomColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
