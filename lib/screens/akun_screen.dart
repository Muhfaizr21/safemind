import 'package:flutter/material.dart';

class AkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F0FF),
      body: Column(
        children: [

          // HEADER GRADIENT with profile
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9575CD), Color(0xFFCE93D8)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 8),

                // Avatar
                CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Icon(Icons.person, size: 48, color: Color(0xFF7C3AED)),
                ),

                SizedBox(height: 12),

                // Name
                Text(
                  'Erwan Kurniawan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                // Edit Profile button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF7C3AED),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profil');
                  },
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C3AED),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // MENU LIST
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _menuTile(Icons.person_outline, 'Profil & Identitas', context, '/profil-identitas'),
                _menuTile(Icons.history, 'Riwayat Laporan', context, '/riwayat-laporan'),
                _menuTile(Icons.lock_outline, 'Keamanan & Privasi', context, '/keamanan-privasi'),
                _menuTile(Icons.palette_outlined, 'Personalisasi', context, '/personalisasi'),
                _menuTile(Icons.help_outline, 'Bantuan & Dukungan', context, '/bantuan-dukungan'),

                SizedBox(height: 24),

                // LOGOUT
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/landing');
                    },
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, BuildContext context, String route) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFEDE7F6), width: 1),
      ),
      child: ListTile(
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF7C3AED), size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF2D1B4E),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9575CD)),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
