import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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
          // Logo ve yükleme göstergesi bölümü
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // Logo bölümü
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                // Yükleme animasyonu
                InkWell(
                  onTap: () {
                    // Yönlendirme yapıyoruz
                    context.go("/home");
                  },
                  child: DotLottieLoader.fromAsset(
                    "assets/motions/loading.lottie",
                    frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                      if (dotlottie != null &&
                          dotlottie.animations.isNotEmpty) {
                        // Animasyon var, göster
                        return Lottie.memory(dotlottie.animations.values.first);
                      } else {
                        // Animasyon yoksa bir yükleme göstergesi göster
                        return Center(child: CircularProgressIndicator());
                      }
                    },
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
