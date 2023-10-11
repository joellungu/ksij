import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ksij_kinshasa/utils/langi.dart';
import 'package:ksij_kinshasa/utils/util.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  String livre = 'assets/quran.pdf';
  //quran//coran//

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Langi.base1,
        title: const Text(
          'CORAN',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     _searchResult = _pdfViewerController.searchText(
          //       'the',
          //       //searchOption: TextSearchOption.caseSensitive,
          //     );
          //     if (kIsWeb) {
          //       setState(() {});
          //     } else {
          //       _searchResult.addListener(() {
          //         if (_searchResult.hasResult) {
          //           setState(() {});
          //         }
          //       });
          //     }
          //   },
          // ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("English"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("French"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("Arab"),
                  value: 3,
                ),
              ];
            }, //
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                "assets/IcBaselineTranslate.svg",
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                //semanticsLabel: e["titre"],
                height: 30,
                width: 30,
              ),
            ),
            onSelected: (t) {
              //
              setState(() {
                //
                if (t == 1) {
                  livre = "assets/quran.pdf";
                } else if (t == 2) {
                  livre = "assets/coran.pdf";
                } else {
                  livre = "assets/quran.pdf";
                }
              });
            },
          ),
          // Visibility(
          //   visible: _searchResult.hasResult,
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.clear,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         _searchResult.clear();
          //       });
          //     },
          //   ),
          // ),
          // Visibility(
          //   visible: _searchResult.hasResult,
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.keyboard_arrow_up,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       _searchResult.previousInstance();
          //     },
          //   ),
          // ),
          // Visibility(
          //   visible: _searchResult.hasResult,
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.keyboard_arrow_down,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       _searchResult.nextInstance();
          //     },
          //   ),
          // ),
        ],
      ),
      body: SfPdfViewer.asset(
        livre,
        controller: _pdfViewerController,
        currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
      ),
    );
  }
}
