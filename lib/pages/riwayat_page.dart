import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Transaksi',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF3773FF),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('transaksi')
            .orderBy('tanggal', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Belum ada transaksi",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            );
          }

          final transaksiList = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transaksiList.length,
            itemBuilder: (context, index) {
              final data = transaksiList[index];
              final tanggal = (data['tanggal'] as Timestamp).toDate();
              final formatTanggal = DateFormat('dd MMM yyyy, HH:mm');

              final layanan = data['layanan'] ?? [];
              final namaLayanan = layanan.isNotEmpty
                  ? layanan.map((item) => item['nama']).join(', ')
                  : '-';

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data['namaPelanggan'] ?? '-',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            formatTanggal.format(tanggal),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Divider(color: Colors.grey[300], thickness: 1),
                      const SizedBox(height: 6),

                      Text(
                        "Pegawai: ${data['pegawai']['nama'] ?? '-'}",
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Layanan: $namaLayanan",
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),

                      const SizedBox(height: 8),
                      Divider(color: Colors.grey[300], thickness: 1),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga:",
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          Text(
                            "Rp ${data['totalHarga']}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Jumlah Bayar:",
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          Text(
                            "Rp ${data['jumlahBayar']}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kembalian:",
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          Text(
                            "Rp ${data['kembalian']}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
