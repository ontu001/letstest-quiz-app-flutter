import 'package:flutter/material.dart';
import 'package:letstest/utils/const.dart';

Widget customOrangeButton(BuildContext context, String text) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    width: 200,
    decoration: BoxDecoration(
      color: kCommonColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 18.0),
    ),
  );
}
