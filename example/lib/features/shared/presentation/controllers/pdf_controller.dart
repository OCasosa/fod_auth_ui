import "dart:convert";

import "package:confirm_alert/show_confirmation_dialog.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:loader_overlay/loader_overlay.dart";

/// Class that handles the PDF generation and management
class PDFController {
  /// Retrieve a pdf file from an asset
  ///
  /// Returns the pdf as a base64 string
  static Future<String?> getPdfFromAsset({
    required BuildContext context,
    required String assetPath,
  }) async {
    try {
      context.loaderOverlay.show(
        progress: "documentRetrieving".tr().toCapitalized(),
      );

      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      final base64String = base64Encode(bytes);

      if (!context.mounted) return null;

      context.loaderOverlay.hide();

      return base64String;
    } catch (e) {
      if (!context.mounted) return null;

      context.loaderOverlay.hide();

      await showErrorDialog(
        context: context,
        texts: ConfirmationDialogTexts(
          title: "errorUnexpected".tr(),
          message: e.toString(),
        ),
      );

      return null;
    }
  }
}
