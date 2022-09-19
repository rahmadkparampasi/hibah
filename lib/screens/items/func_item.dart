import 'package:flutter/material.dart';

void showBottomModal(BuildContext context, dynamic child, double height) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return height == 0
          ? Container(
              height: height,
              color: const Color(0xFF737373),
              child: Container(
                child: child,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            )
          : Container(
              height: height,
              color: const Color(0xFF737373),
              child: Container(
                child: child,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            );
    },
  );
}
