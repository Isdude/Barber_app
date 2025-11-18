import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CetakResiPage extends StatefulWidget {
  final String namaPelanggan;
  final List<Map<String, dynamic>> layanan;
  final num totalHarga;
  final num jumlahBayar;
  final num kembalian;

  const CetakResiPage({
    super.key,
    required this.namaPelanggan,
    required this.layanan,
    required this.totalHarga,
    required this.jumlahBayar,
    required this.kembalian,
  });

  @override
  State<CetakResiPage> createState() => _CetakResiPageState();
}

class _CetakResiPageState extends State<CetakResiPage> {
  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3773FF),
        centerTitle: true,
        title: Text(
          "Struk Pembayaran",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "💈 BARBERSHOP GANTENG",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3773FF),
                        ),
                      ),
                      Text(
                        "Jl. Raya Cukur No. 21, Bandung",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "Telp: 0812-3456-7890",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Tanggal: $date",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Pelanggan: ${widget.namaPelanggan}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      const Divider(thickness: 1),

                      const Divider(thickness: 1),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // DAFTAR LAYANAN
                Text(
                  "Daftar Layanan:",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                ...widget.layanan.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['nama'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Rp ${NumberFormat('#,###', 'id_ID').format(item['subtotal'] ?? 0)}",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const Divider(thickness: 1),
                const SizedBox(height: 6),

                // RINCIAN PEMBAYARAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Harga",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rp ${NumberFormat('#,###', 'id_ID').format(widget.totalHarga)}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jumlah Bayar", style: GoogleFonts.poppins()),
                    Text(
                      "Rp ${NumberFormat('#,###', 'id_ID').format(widget.jumlahBayar)}",
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kembalian", style: GoogleFonts.poppins()),
                    Text(
                      "Rp ${NumberFormat('#,###', 'id_ID').format(widget.kembalian)}",
                      style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 1),

                const SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Terima kasih telah berkunjung!",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Kami tunggu kedatangan Anda kembali 💈",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Proses cetak...")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3773FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: Text(
                      "Cetak Struk",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
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
