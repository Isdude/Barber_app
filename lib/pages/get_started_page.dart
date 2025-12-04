import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              "assets/get.jpg",  // ganti nanti
              fit: BoxFit.cover,
            ),
          ),

          // --- Lapisan Gelap ---
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          // --- Content ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Kelola,\ntransaksi,\nlayanan barber",
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "Aplikasi kasir modern untuk barbershop.\nCepat, mudah, praktis.",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                // --- Button Get Started ---
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                  Color(0xFF0047FF),
                  Color(0xFF3797FF),
                  Color(0xFF5AD2FF),
                ],
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          // Icon bulat kecil
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            "Get started",
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
