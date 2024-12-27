import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/controllers/riwayat_pengaduan_controller.dart';

class RiwayatPengaduanView extends GetView<RiwayatPengaduanController> {
  final Color primaryColor = Color(0xFF004D99); // Adjusted color tone for a more modern look

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Pengaduan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: StreamBuilder(
          stream: controller.getPengaduanStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: 100,
                      color: primaryColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Belum ada pengaduan',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var pengaduan = snapshot.data!.docs[index];
                return _buildPengaduanItem(pengaduan);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPengaduanItem(QueryDocumentSnapshot pengaduan) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  pengaduan['nama'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                controller.formatTanggalSingkat(pengaduan['tanggal']),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          subtitle: Text(
            pengaduan['isiPengaduan'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: primaryColor,
          ),
          onTap: () => _showPengaduanDetail(pengaduan),
          // Add delete button
          leading: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deletePengaduan(pengaduan.id),
          ),
        ),
      ),
    );
  }

  void _deletePengaduan(String pengaduanId) {
    Get.dialog(
      AlertDialog(
        title: Text('Hapus Pengaduan'),
        content: Text('Apakah Anda yakin ingin menghapus pengaduan ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await controller.hapusPengaduan(pengaduanId);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showPengaduanDetail(QueryDocumentSnapshot pengaduan) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.95,
          maxChildSize: 0.98,
          minChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([  
                        Text(
                          'Detail Pengaduan',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildInfoHeader(pengaduan),
                        SizedBox(height: 16),
                        _buildContactInfo(pengaduan),
                        SizedBox(height: 16),
                        _buildAddressSection(pengaduan),
                        SizedBox(height: 16),
                        _buildPengaduanContent(pengaduan),
                        SizedBox(height: 16),
                        if (pengaduan['buktiGambar'] != null)
                          _buildImageSection(pengaduan),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoHeader(QueryDocumentSnapshot pengaduan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            pengaduan['nama'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          controller.formatTanggalLengkap(pengaduan['tanggal']),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(QueryDocumentSnapshot pengaduan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kontak',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.email, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              pengaduan['email'],
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.phone, size: 16, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              pengaduan['nomorTelepon'],
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressSection(QueryDocumentSnapshot pengaduan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          pengaduan['alamat'],
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPengaduanContent(QueryDocumentSnapshot pengaduan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Isi Pengaduan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          pengaduan['isiPengaduan'],
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildImageSection(QueryDocumentSnapshot pengaduan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bukti Gambar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        CachedNetworkImage(
          imageUrl: pengaduan['buktiGambar'],
          placeholder: (context, url) => CircularProgressIndicator(
            color: primaryColor,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
