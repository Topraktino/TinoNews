import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const NewsDetail(this.title, this.description, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Text(
                'Resim yüklenemedi',
                style: GoogleFonts.poppins(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
