import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: arkaplanRenkim,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: 350,
                  height: 350,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.go("/home");
                  },
                  child: DotLottieLoader.fromAsset(
                    "assets/motions/loading.lottie",
                    frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                      if (dotlottie != null &&
                          dotlottie.animations.isNotEmpty) {
                        return Lottie.memory(dotlottie.animations.values.first);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Yükleniyor...',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
