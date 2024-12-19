import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoPage extends StatelessWidget {
  final String phone = "+6281234567890"; // Ganti dengan nomor WhatsApp yang valid
  final String email = "johndoe@example.com";
  final String address = "Jl. Contoh No. 123, Jakarta, Indonesia";

  // Metode untuk menghubungi melalui WhatsApp
  void _launchWhatsApp() async {
    final String whatsappUrl = "https://wa.me/${phone.substring(1)}"; // Menghapus '+' dari nomor
    try {
      await launch(whatsappUrl);
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  // Metode untuk menghubungi melalui email
  void _launchEmail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('Subject: Pertanyaan dari Aplikasi'),
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertanyaan Lebih Lanjut'),
        backgroundColor:Color.fromARGB(226, 0, 77, 153),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            SizedBox(height: 20),
            Text(
              'Ingin Bertanya lebih Lanjut?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 73, 124, 171),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Hubungi kontak di bawah ini',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),

            // Informasi Kontak
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nomor Telepon
                Row(
                  children: [
                    Icon(Icons.phone, color: const Color.fromARGB(255, 73, 124, 171)),
                    SizedBox(width: 10),
                    Text(
                      'Telepon: $phone',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Email
                Row(
                  children: [
                    Icon(Icons.email, color: const Color.fromARGB(255, 73, 124, 171)),
                    SizedBox(width: 10),
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Alamat
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: const Color.fromARGB(255, 73, 124, 171)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Alamat: $address',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Tombol untuk menghubungi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _launchWhatsApp,
                  icon: Icon(Icons.message),
                  label: Text('WhatsApp'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _launchEmail,
                  icon: Icon(Icons.email),
                  label: Text('Email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}