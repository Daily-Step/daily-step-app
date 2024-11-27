import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

void showConfirmModal({
  required BuildContext context,
  required Widget content,
  required String confirmText,
  required VoidCallback onClickConfirm,
  required bool isCancelButton,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                height20,
                content,
                height20,
                Row(
                  children: [
                    if (isCancelButton) ...[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            onClickConfirm();
                          },
                          child: Text(
                            '닫기',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ],
                    if (isCancelButton)
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            onClickConfirm();
                          },
                          child: Text(confirmText, style: TextStyle(color: Colors.white),),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}