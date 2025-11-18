import 'package:barber_app/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pilih_pelanggan_page.dart';
import 'pilih_layanan_item_page.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});
  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  String? namaPelanggan;
  String? noHp;
  final List<Map<String, dynamic>> layanan = [];
  Future<void> pilihPelanggan() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PilihPelangganPage()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        namaPelanggan = result['nama'];
        noHp = result['noHp'];
      });
      // Get.snackbar(
      //   "Berhasil",
      //   'Pelanggan "$namaPelanggan" berhasil dipilih',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    }
  }

  Future<void> pilihLayananItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PilihLayananItemPage()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        final harga = result['harga'] is String
            ? int.tryParse(result['harga'].replaceAll('.', '')) ?? 0
            : result['harga'];
        layanan.add({
          "nama": result['nama'],
          "subtotal": harga,
          "deskripsi": result['deskripsi'],
        });
      });
      // Get.snackbar(
      //   "Berhasil",
      //   'Layanan "${result['nama']}" berhasil ditambahkan',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    }
  }

  int _hitungTotal() {
    int total = 0;
    for (var item in layanan) {
      total += (item['subtotal'] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transaksi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFECECEC),
                    child: Icon(Icons.person, color: Color(0xFF3773FF)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaPelanggan ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: namaPelanggan != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          'No. HP: ${noHp ?? "-"}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: pilihPelanggan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3773FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      namaPelanggan == null
                          ? "Cari Pelanggan"
                          : "Ubah Pelanggan",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail Order",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: pilihLayananItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3773FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Tambah Item",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: layanan.isEmpty
                  ? Center(
                      child: Text(
                        "Belum ada item ditambahkan.",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: layanan.length,
                      itemBuilder: (context, index) {
                        final item = layanan[index];
                        return Card(
                          elevation: 4,
                          shadowColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF3773FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.cut,
                                color: Color(0xFF3773FF),
                              ),
                            ),
                            title: Text(
                              item['nama'],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                if (item['deskripsi'] != null)
                                  Text(
                                    item['deskripsi'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  "Subtotal: Rp ${item['subtotal']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF2ECC71),
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  layanan.removeAt(index);
                                });
                                Get.snackbar(
                                  "Berhasil",
                                  'Item "${item['nama']}" berhasil dihapus',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                                size: 26,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: "Keterangan",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF3773FF),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Harga:\n${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(_hitungTotal())}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (namaPelanggan == null) {
                  Get.snackbar(
                    "Error",
                    "Pilih pelanggan terlebih dahulu sebelum checkout.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      pelanggan: {"nama": namaPelanggan!, "noHp": noHp ?? "-"},
                      layanan: layanan,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Checkout",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
