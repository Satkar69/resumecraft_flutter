import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:resumecraft/config.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class PDFPreviewPage extends StatefulWidget {
  @override
  _PDFPreviewPageState createState() => _PDFPreviewPageState();
}

class _PDFPreviewPageState extends State<PDFPreviewPage> with UserProfileMixin {
  List<String> _localPdfPaths = [];
  bool _isLoading = true;
  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfileAndDownloadPdfs();
  }

  Future<void> _loadUserProfileAndDownloadPdfs() async {
    await loadUserProfile();
    setState(() {
      _isProfileLoaded = true; // Mark profile as loaded
      loadUserProfile();
    });
    _downloadPdfs();
  }

  // '${Config.getPdfs}$pdfUrl'
  Future<void> _downloadPdfs() async {
    try {
      List<String> paths = [];
      for (String pdfUrl in resume) {
        String localPath = await _downloadFile('${Config.getPdfs}$pdfUrl');
        if (localPath.isNotEmpty) {
          paths.add(localPath);
        }
      }
      if (paths.isNotEmpty) {
        setState(() {
          _localPdfPaths = paths;
          _isLoading = false;
        });
      } else {
        print('Error: No PDFs were downloaded.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error downloading PDFs: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final directory = await getApplicationDocumentsDirectory();
        final filePath = path.join(directory.path, path.basename(url));

        final file = File(filePath);
        await file.writeAsBytes(bytes);
        print('Downloaded PDF to: $filePath');

        // Verify the file size
        if (await file.length() > 0) {
          return filePath;
        } else {
          print('Error: Downloaded file is empty.');
          return '';
        }
      } else {
        print(
            'Error: Failed to download PDF. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = HexColor('#283B71');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, const Color.fromARGB(255, 26, 101, 162)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Downloads', style: TextStyle(color: Colors.white)),
              ),
              _isLoading
                  ? Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Expanded(
                      child: _localPdfPaths.isEmpty
                          ? Center(child: Text('No PDFs available'))
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        constraints.maxWidth > 600 ? 2 : 1,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: _localPdfPaths.length,
                                  itemBuilder: (context, index) {
                                    return PDFPreviewCard(
                                        pdfPath: _localPdfPaths[index]);
                                  },
                                );
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFPreviewCard extends StatelessWidget {
  final String pdfPath;
  const PDFPreviewCard({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: PDFView(
                filePath: pdfPath,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                onError: (error) {
                  print('Error loading PDF: $error');
                },
                onRender: (pages) {
                  print('PDF Rendered with $pages pages');
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'CV_${DateTime.now().millisecondsSinceEpoch}.pdf',
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
