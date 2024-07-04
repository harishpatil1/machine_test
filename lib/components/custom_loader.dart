import 'package:flutter/material.dart';
import '../core_utils/app_colors.dart';

class CustomLoader {
  static void fetchData(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outside it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Loading...')
                ],
              ),
            ),
          );
        });
  }
}
