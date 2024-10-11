import 'dart:io';
import 'dart:typed_data';
import 'package:coswan/screens/homepage.dart';
import 'package:coswan/services/e_receipt_api.dart';
import 'package:coswan/utils/lineargradient.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EReceipt extends StatefulWidget {
  final List<String> orderid;
  final List<String> transactionId;

  const EReceipt({
    super.key,
    required this.orderid,
    required this.transactionId,
  });

  @override
  State<EReceipt> createState() => _EReceiptState();
}

class _EReceiptState extends State<EReceipt> {
  Uint8List? pdfData;
  PdfViewerController pdfViewerController = PdfViewerController();
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  void dispose() {
    pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(gradient: gradient),
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'E- Receipt',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            bottomNavigationBar: SizedBox(
              height: 100.h,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //   downloadpdf();
                          sharePDF();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.h)),
                        child: Text(
                          'Share',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 10.h)),
                        child: Text(
                          'Order Again',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
            body: pdfData == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SfPdfViewer.memory(
                      pdfData!,
                      controller: pdfViewerController,
                      enableDoubleTapZooming: true,
                      pageLayoutMode: PdfPageLayoutMode.continuous,
                      scrollDirection: PdfScrollDirection.vertical,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildrowtext(String leftText, String rightText, TextStyle leftStyle,
      TextStyle rightStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: leftStyle,
        ),
        Text(
          rightText,
          style: rightStyle,
        )
      ],
    );
  }

  void fetchdata() async {
    final response = await EReceiptAPI.generateReceipt(
        context, widget.orderid, widget.transactionId);
    setState(() {
      pdfData = response!;
    });
  }

  Future<void> sharePDF() async {
    if (pdfData == null) return;

    try {
      // Get the directory where the PDF will be saved
      Directory directory = await getTemporaryDirectory();
      String filePath = '${directory.path}/receipt.pdf'; // Name your PDF file
      File file = File(filePath);

      // Write the PDF data to the file
      await file.writeAsBytes(pdfData!);

      // Convert the file path to an XFile object
      XFile xfile = XFile(filePath);

      // Use Share.shareXFiles to share the file directly
      await Share.shareXFiles([xfile], text: 'Here is your PDF file.');

      // Optionally, delete the temporary file after sharing
      // await file.delete();
    } catch (e) {
      print('Error sharing PDF: $e');
    } 
  }
}


  // Future<void> downloadpdf() async {
  //   if (pdfData == null) return;
  //   try {
  //     final directory = await getExternalStorageDirectory();
  //     final downloadsPath = path.join(directory!.path, 'Download');

  //     // Ensure the Downloads directory exists
  //     final downloadsDir = Directory(downloadsPath);
  //     if (!downloadsDir.existsSync()) {
  //       downloadsDir.createSync(recursive: true);
  //     }

  //     final filePath = path.join(downloadsPath, 'receipt.pdf');
  //     final file = File(filePath);
  //     print('PDF saved to $filePath');
  //     await file.writeAsBytes(pdfData!);
  //     CustomNotifyToast.showCustomToast(
  //         context, 'Receipt Successfully Downloaded');
  //   } catch (e) {
  //     print('Error downloading PDF: $e');
  //   }
  // }

