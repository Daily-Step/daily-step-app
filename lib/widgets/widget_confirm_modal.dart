import 'package:dailystep/common/util/size_util.dart';
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
          backgroundColor: WAppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * su),
          ),
          child: Container(
            width: 380 * su,
            height: 250 * su,
            padding: EdgeInsets.symmetric(horizontal: 20.0 * su, vertical: 10 * su),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                height60,
                content,
                height60,
                Row(
                  children: [
                    if (isCancelButton) ...[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16 * su),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
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
                              borderRadius: BorderRadius.circular(16 * su),
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