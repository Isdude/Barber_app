import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class AddPegawaiPage extends StatefulWidget {
  const AddPegawaiPage({super.key});

  @override
  State<AddPegawaiPage> createState() => _AddPegawaiPageState();
}

class _AddPegawaiPageState extends State<AddPegawaiPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController spesialisController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: Text(
          'Tambah Pegawai',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3773FF),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.96),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3773FF).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 36,
                        color: Color(0xFF3773FF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Data Pegawai Baru",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Isi informasi lengkap pegawai barbershop",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildTextField(
                controller: namaController,
                label: "Nama Pegawai",
                icon: Icons.person,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: spesialisController,
                label: "Spesialis",
                icon: Icons.cut_rounded,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: noHpController,
                label: "Nomor HP",
                icon: Icons.phone,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                controller: alamatController,
                label: "Alamat",
                icon: Icons.home,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3773FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 8,
                    shadowColor: Colors.blueAccent.withOpacity(0.4),
                  ),
                  icon: const Icon(Icons.save_rounded, color: Colors.white),
                  label: Text(
                    'Simpan Pegawai',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    if (namaController.text.isEmpty ||
                        spesialisController.text.isEmpty ||
                        noHpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua field wajib diisi!'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    await db.collection('pegawai').add({
                      'nama': namaController.text,
                      'spesialis': spesialisController.text,
                      'noHp': noHpController.text,
                      'alamat': alamatController.text,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    Get.snackbar(
                      "Berhasil",
                      "Data pegawai telah disimpan.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,

  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 14.5),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF3773FF)),
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3773FF), width: 1.5),
        ),
      ),
    );
  }
}
