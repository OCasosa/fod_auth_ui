part of "../libraries/pdf_viewer_library.dart";

/// Page that displays a PDF file.
/// It uses the [PdfViewer] widget to show the PDF content.
@RoutePage()
class PdfViewerPage extends StatelessWidget {
  /// Page that displays a PDF file.
  const PdfViewerPage({
    required this.fileName,
    this.base64File,
    super.key,
  });

  /// The file name of the PDF file.
  final String fileName;

  /// The base64 encoded string of the PDF file.
  final String? base64File;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(fileName),
        ),
        body: PDFView(
          pdfData: base64File != null ? base64Decode(base64File!) : null,
          enableSwipe: true,
          swipeHorizontal: true,
          nightMode: context.isDarkMode,
          autoSpacing: false,
          pageFling: true,
          pageSnap: true,
          defaultPage: 0,
          fitPolicy: FitPolicy.WIDTH,
          onPageError: (page, error) => _onError(context, error),
          onError: (e) => _onError(context, e),
        ),
      );

  Future _onError(BuildContext context, Object e) async {
    await showErrorDialog(
      context: context,
      texts: ConfirmationDialogTexts(
        title: "errorUnexpected".tr(),
        message: e.toString(),
      ),
    );

    if (!context.mounted) return;

    unawaited(context.router.maybePop());
  }
}
