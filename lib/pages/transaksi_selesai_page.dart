import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'cetak_resi_page.dart';
import 'package:get/get.dart';


class TransaksiSelesaiPage extends StatelessWidget {
  final String namaPelanggan;
  final num totalHarga;
  final num jumlahBayar;
  final num kembalian;
  final List<Map<String, dynamic>> layanan;

  const TransaksiSelesaiPage({
    super.key,
    required this.namaPelanggan,
    required this.totalHarga,
    required this.jumlahBayar,
    required this.kembalian,
    required this.layanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3773FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Transaksi Berhasil Disimpan !!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 25),

                // Info Transaksi
                Text(
                  "Total Harga : Rp. ${NumberFormat('#,###', 'id_ID').format(totalHarga)}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Jumlah DP : Rp. ${NumberFormat('#,###', 'id_ID').format(jumlahBayar)}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Kembalian : Rp. ${NumberFormat('#,###', 'id_ID').format(kembalian)}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF28A745),
                  ),
                ),
                const SizedBox(height: 40),

                Row(
  children: [
    Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(50),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF3773FF),
              child: Icon(Icons.check, color: Colors.white, size: 26),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Selesai",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CetakResiPage(
                  namaPelanggan: namaPelanggan,
                  totalHarga: totalHarga,
                  jumlahBayar: jumlahBayar,
                  kembalian: kembalian,
                  layanan: layanan,
                ),
              ));
            },
            borderRadius: BorderRadius.circular(50),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF3773FF),
              child: Icon(Icons.print, color: Colors.white, size: 26),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Cetak",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.snackbar(
                "Info",
                "Fitur bagikan struk belum tersedia.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
            borderRadius: BorderRadius.circular(50),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF3773FF),
              child: Icon(Icons.share, color: Colors.white, size: 26),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Bagikan Struk",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  ],
),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      "Buat Transaksi Baru",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}