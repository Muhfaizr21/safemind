const express = require('express');
const mysql = require('mysql2');
const dotenv = require('dotenv');
const cors = require('cors');

dotenv.config();

const app = express();
app.use(cors()); // Izinkan semua akses (CORS)
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
});

db.connect((err) => {
    if (err) {
        console.error('❌ Gagal terhubung ke MySQL:');
        console.error('Kode Error:', err.code);
        console.error('Pesan:', err.message);
        return;
    }
    console.log('✅ Terhubung ke database MySQL: ' + process.env.DB_NAME);
    
    // Inisialisasi Tabel Users & Akun Percobaan
    const createTableQuery = `
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(255) NOT NULL UNIQUE,
            password VARCHAR(255) NOT NULL,
            email VARCHAR(255),
            phone VARCHAR(20),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    `;
    db.query(createTableQuery, (err) => {
        if (err) console.error('Gagal membuat tabel users:', err);
        else {
            // Pastikan kolom phone & created_at ada (Cara manual agar kompatibel dengan versi MySQL lama)
            db.query('ALTER TABLE users ADD COLUMN phone VARCHAR(20)', (err) => {
                if (err && err.code !== 'ER_DUP_FIELDNAME') {
                    // Hanya log jika errornya bukan karena kolom sudah ada
                }
            });
            db.query('ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP', (err) => {
                if (err && err.code !== 'ER_DUP_FIELDNAME') {
                    // Hanya log jika errornya bukan karena kolom sudah ada
                }
            });
            
            db.query('SELECT * FROM users WHERE username = "user_test"', (err, results) => {
                if (results && results.length === 0) {
                    db.query('INSERT INTO users (username, password, email, phone) VALUES ("user_test", "password123", "test@safemind.com", "+6281234567890")', (err) => {
                        if (err) console.error('Gagal membuat akun percobaan:', err);
                        else console.log('✅ Akun percobaan siap: user_test / password123');
                    });
                }
            });

            // Tabel Laporan
            const createReportsTable = `
                CREATE TABLE IF NOT EXISTS reports (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255),
                    category VARCHAR(100),
                    location VARCHAR(255),
                    incident_date VARCHAR(100),
                    description TEXT,
                    is_anonymous BOOLEAN DEFAULT FALSE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            `;
            db.query(createReportsTable, (err) => {
                if (err) console.error('Gagal membuat tabel reports:', err);
            });
        }
    });
});

            // Tabel Sessions (Perangkat Aktif)
            const createSessionsTable = `
                CREATE TABLE IF NOT EXISTS sessions (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255),
                    device_name VARCHAR(255),
                    last_active TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    ip_address VARCHAR(100)
                )
            `;
            db.query(createSessionsTable, (err) => {
                if (err) console.error('Gagal membuat tabel sessions:', err);
            });
        }
    });
});

// Endpoint Ambil Perangkat Aktif
app.get('/api/sessions/:username', (req, res) => {
    const username = req.params.username;
    const query = 'SELECT * FROM sessions WHERE username = ? ORDER BY last_active DESC';
    
    db.query(query, [username], (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil data perangkat' });
        res.json({ success: true, data: results });
    });
});

// Endpoint Simpan Laporan
app.post('/api/reports', (req, res) => {
    const { username, category, location, incident_date, description, is_anonymous } = req.body;
    const query = 'INSERT INTO reports (username, category, location, incident_date, description, is_anonymous) VALUES (?, ?, ?, ?, ?, ?)';
    
    db.query(query, [username, category, location, incident_date, description, is_anonymous], (err, results) => {
        if (err) {
            console.error('Error saving report:', err);
            return res.status(500).json({ success: false, message: 'Gagal menyimpan laporan' });
        }
        res.json({ success: true, message: 'Laporan berhasil terkirim' });
    });
});

// Endpoint Ubah Kata Sandi
app.post('/api/change-password', (req, res) => {
    const { username, oldPassword, newPassword } = req.body;
    
    // Cek password lama
    db.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, oldPassword], (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Error server' });
        
        if (results.length > 0) {
            // Update ke password baru
            db.query('UPDATE users SET password = ? WHERE username = ?', [newPassword, username], (err) => {
                if (err) return res.status(500).json({ success: false, message: 'Gagal mengubah password' });
                res.json({ success: true, message: 'Password berhasil diubah' });
            });
        } else {
            res.status(401).json({ success: false, message: 'Password lama salah' });
        }
    });
});

// Endpoint Ambil Riwayat Laporan
app.get('/api/reports/:username', (req, res) => {
    const username = req.params.username;
    const query = 'SELECT * FROM reports WHERE username = ? ORDER BY created_at DESC';
    
    db.query(query, [username], (err, results) => {
        if (err) {
            return res.status(500).json({ success: false, message: 'Gagal mengambil riwayat' });
        }
        res.json({ success: true, data: results });
    });
});

// Endpoint Register
app.post('/api/register', (req, res) => {
    const { username, password, email, phone } = req.body;
    const query = 'INSERT INTO users (username, password, email, phone) VALUES (?, ?, ?, ?)';
    
    db.query(query, [username, password, email, phone], (err, results) => {
        if (err) {
            if (err.code === 'ER_DUP_ENTRY') {
                return res.status(400).json({ success: false, message: 'Username sudah digunakan' });
            }
            return res.status(500).json({ success: false, message: 'Gagal mendaftar' });
        }
        res.json({ success: true, message: 'Registrasi berhasil! Silakan login.' });
    });
});

// Endpoint Login
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
    
    db.query(query, [username, password], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error server' });
        if (results.length > 0) {
            const user = results[0];
            
            // Catat sesi baru (Mock device name dari user-agent)
            const deviceName = req.headers['user-agent'] || 'Unknown Device';
            const ipAddress = req.ip || '0.0.0.0';
            
            db.query('INSERT INTO sessions (username, device_name, ip_address) VALUES (?, ?, ?)', [username, deviceName, ipAddress], (err) => {
                if (err) console.error('Gagal mencatat sesi:', err);
            });

            res.json({ success: true, message: 'Login berhasil', user: user });
        } else {
            res.status(401).json({ success: false, message: 'Username atau password salah' });
        }
    });
});

app.get('/', (req, res) => {
    res.send('SafeMind Backend API is running...');
});

// Endpoint Update Profile
app.post('/api/update-profile', (req, res) => {
    const { username, email, phone } = req.body;
    const query = 'UPDATE users SET email = ?, phone = ? WHERE username = ?';
    
    db.query(query, [email, phone, username], (err, results) => {
        if (err) {
            console.error('❌ Database Error saat Update Profile:', err);
            return res.status(500).json({ success: false, message: 'Gagal memperbarui profil: ' + err.sqlMessage });
        }
        res.json({ success: true, message: 'Profil berhasil diperbarui' });
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});
