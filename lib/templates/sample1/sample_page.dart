import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ProfessionalResumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Professional Resume',
      theme: ThemeData(
        primaryColor: Color(0xFF283B71),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  final GlobalKey _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Resume', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF283B71),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile_picture.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'JULIANA SILVA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Art Director',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 24),
                    buildSectionTitle('CONTACT'),
                    buildContactInfo(Icons.phone, '+123-456-7890'),
                    buildContactInfo(Icons.email, 'hello@reallygreatsite.com'),
                    buildContactInfo(Icons.web, 'www.reallygreatsite.com'),
                    buildContactInfo(Icons.location_on,
                        '123 Anywhere St, Any City, ST 12345'),
                    SizedBox(height: 24),
                    buildSectionTitle('EDUCATION'),
                    buildEducationItem('Bachelor of Design',
                        'Wardiere University', '2006 - 2008'),
                    SizedBox(height: 24),
                    buildSectionTitle('EXPERTISE'),
                    buildExpertiseItem('Web Design'),
                    buildExpertiseItem('Branding'),
                    buildExpertiseItem('Graphic Design'),
                    buildExpertiseItem('SEO'),
                    buildExpertiseItem('Marketing'),
                    SizedBox(height: 24),
                    buildSectionTitle('LANGUAGE'),
                    buildExpertiseItem('English'),
                    buildExpertiseItem('French'),
                    SizedBox(height: 24),
                    buildSectionTitle('REFERENCES'),
                    buildReferenceItem('Estelle Darcy', 'Wardiere Inc. / CEO',
                        '+123-456-7890', 'hello@reallygreatsite.com'),
                    buildReferenceItem('Harper Russo', 'Wardiere Inc. / CEO',
                        '+123-456-7890', 'hello@reallygreatsite.com'),
                  ],
                ),
              ),
              SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle('ABOUT ME'),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pharetra in lorem at laoreet. Donec hendrerit libero eget est tempor, quis tempus arcu elementum.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 24),
                    buildSectionTitle('WORK EXPERIENCE'),
                    buildWorkExperienceItem(
                      'Jan 2022 - Present',
                      'Digital Marketing Manager',
                      'Company Name | 123 Anywhere St., Any City',
                      'Managed digital marketing campaigns, analyzed web traffic, and collaborated with the design team to improve user experience.',
                    ),
                    buildWorkExperienceItem(
                      '2017 - 2019',
                      'Social Media Manager',
                      'Company Name | 123 Anywhere St., Any City',
                      'Developed social media strategies, increased engagement by 30%, and managed content calendars.',
                    ),
                    buildWorkExperienceItem(
                      '2015 - 2017',
                      'Social Media Manager',
                      'Company Name | 123 Anywhere St., Any City',
                      'Led social media campaigns for product launches and collaborated with influencers to boost brand awareness.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generateAndDownloadPdf(context),
        child: Icon(Icons.download),
        backgroundColor: Color(0xFF283B71),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF283B71),
      ),
    );
  }

  Widget buildContactInfo(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              info,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEducationItem(String degree, String university, String duration) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            university,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            duration,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget buildExpertiseItem(String skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '- $skill',
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      ),
    );
  }

  Widget buildReferenceItem(
      String name, String position, String phone, String email) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            position,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            'Phone: $phone',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          Text(
            'Email: $email',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Widget buildWorkExperienceItem(
      String duration, String title, String company, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            duration,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            company,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndDownloadPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
                "Your PDF content goes here"), // Replace with your content
          );
        },
      ),
    );

    // Use the printing package to save or print the PDF
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'resume.pdf',
    );
  }
}
