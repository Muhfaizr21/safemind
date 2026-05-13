import 'package:flutter/material.dart';

class ArtikelCard extends StatelessWidget {
  final String judul;
  final String deskripsi;

  const ArtikelCard({
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFD8CCF0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9575CD).withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2D1B4E),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: TextStyle(
                    color: Color(0xFF7B6F8A),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7C3AED),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              elevation: 0,
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
            child: Text('Baca Selengkapnya'),
          ),
        ],
      ),
    );
  }
}
