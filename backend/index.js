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
            // Pastikan kolom phone, created_at, dan role ada
            db.query('ALTER TABLE users ADD COLUMN phone VARCHAR(20)', (err) => {});
            db.query('ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP', (err) => {});
            db.query('ALTER TABLE users ADD COLUMN role ENUM("user", "admin") DEFAULT "user"', (err) => {});
            
            // Buat akun user percobaan
            db.query('SELECT * FROM users WHERE username = "user_test"', (err, results) => {
                if (results && results.length === 0) {
                    db.query('INSERT INTO users (username, password, email, phone, role) VALUES ("user_test", "password123", "test@safemind.com", "+6281234567890", "user")', (err) => {
                        if (err) console.error('Gagal membuat akun percobaan:', err);
                        else console.log('✅ Akun user siap: user_test / password123');
                    });
                }
            });

            // Buat akun ADMIN default
            db.query('SELECT * FROM users WHERE username = "admin"', (err, results) => {
                if (results && results.length === 0) {
                    db.query('INSERT INTO users (username, password, email, phone, role) VALUES ("admin", "admin123", "admin@safemind.com", "+62800000000", "admin")', (err) => {
                        if (err) console.error('Gagal membuat akun admin:', err);
                        else console.log('✅ Akun ADMIN siap: admin / admin123');
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

            // Tabel Artikel Edukasi
            const createArticlesTable = `
                CREATE TABLE IF NOT EXISTS articles (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255),
                    category VARCHAR(100),
                    image_url VARCHAR(255),
                    content TEXT,
                    author VARCHAR(100),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            `;
            db.query(createArticlesTable, (err) => {
                if (err) console.error('Gagal membuat tabel articles:', err);
                else {
                    db.query('SELECT COUNT(*) as count FROM articles', (err, results) => {
                        if (results && results[0].count === 0) {
                            const seedQuery = 'INSERT INTO articles (title, category, image_url, content, author) VALUES ?';
                            const values = [
                                ['Mengenal Kecemasan Berlebih', 'Psikologi', 'https://images.unsplash.com/photo-1518491755924-dfb3d972d17d', 'Kecemasan adalah hal wajar, namun jika berlebih...', 'Dr. SafeMind'],
                                ['Cara Mengatasi Bullying', 'Sosial', 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3', 'Bullying dapat memberikan dampak jangka panjang...', 'Tim Edukasi'],
                                ['Pentingnya Self-Care', 'Kesehatan', 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b', 'Menjaga diri sendiri bukan berarti egois...', 'Sobat Sehat']
                            ];
                            db.query(seedQuery, [values], () => {});
                        }
                    });
                }
            });

            // Tabel Video Edukasi
            const createVideosTable = `
                CREATE TABLE IF NOT EXISTS videos (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255),
                    url VARCHAR(255),
                    duration VARCHAR(50)
                )
            `;
            db.query(createVideosTable, (err) => {
                if (err) console.error('Gagal membuat tabel videos:', err);
                else {
                    db.query('SELECT COUNT(*) as count FROM videos', (err, results) => {
                        if (results && results[0].count === 0) {
                            const seedQuery = 'INSERT INTO videos (title, url, duration) VALUES ?';
                            const values = [
                                ['Cara Mengatasi Anxiety', 'https://youtu.be/BwivvpCyVAA?si=PSeqHUfmZaNyQGzX', '8 menit'],
                                ['Mengenal Kesehatan Mental', 'https://www.youtube.com/watch?v=LdBGbmY5Ips', '10 menit'],
                                ['Cara Mengatasi Depresi', 'https://www.youtube.com/watch?v=5MuImqhT8oM', '12 menit']
                            ];
                            db.query(seedQuery, [values], () => {});
                        }
                    });
                }
            });

            // Tabel Notifikasi
            const createNotificationsTable = `
                CREATE TABLE IF NOT EXISTS notifications (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255),
                    title VARCHAR(255),
                    message TEXT,
                    is_read BOOLEAN DEFAULT FALSE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            `;
            db.query(createNotificationsTable, (err) => {
                if (err) console.error('Gagal membuat tabel notifications:', err);
            });

            // Tabel Psikolog
            const createPsychologistsTable = `
                CREATE TABLE IF NOT EXISTS psychologists (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(255),
                    specialization VARCHAR(255),
                    experience VARCHAR(50),
                    rating FLOAT,
                    phone VARCHAR(20),
                    is_available BOOLEAN DEFAULT TRUE
                )
            `;
            db.query(createPsychologistsTable, (err) => {
                if (err) console.error('Gagal membuat tabel psychologists:', err);
                else {
                    db.query('SELECT COUNT(*) as count FROM psychologists', (err, results) => {
                        if (results && results[0].count === 0) {
                            const seedQuery = 'INSERT INTO psychologists (name, specialization, experience, rating, phone) VALUES ?';
                            const values = [
                                ['Dr. Sari Wulandari, M.Psi', 'Psikologi Klinis & Trauma', '8 Tahun', 4.9, '+6281234567891'],
                                ['Dr. Budi Santoso, M.Psi', 'Kesehatan Mental & Konseling', '6 Tahun', 4.8, '+6281234567892'],
                                ['Dr. Anisa Putri, M.Psi', 'Psikologi Keluarga & Anak', '10 Tahun', 5.0, '+6281234567893']
                            ];
                            db.query(seedQuery, [values], () => {});
                        }
                    });
                }
            });
        }
    });
});

// Endpoint Ambil Daftar Artikel
app.get('/api/articles', (req, res) => {
    const query = 'SELECT * FROM articles ORDER BY created_at DESC';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil artikel' });
        res.json({ success: true, data: results });
    });
});

// Endpoint Ambil Daftar Video
app.get('/api/videos', (req, res) => {
    const query = 'SELECT * FROM videos ORDER BY id ASC';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil video' });
        res.json({ success: true, data: results });
    });
});

// Endpoint Ambil Daftar Laporan User
app.get('/api/reports/:username', (req, res) => {
    const username = req.params.username;
    const query = 'SELECT * FROM reports WHERE username = ? ORDER BY created_at DESC';
    db.query(query, [username], (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil data laporan' });
        res.json({ success: true, data: results });
    });
});

// Endpoint Ambil Notifikasi User
app.get('/api/notifications/:username', (req, res) => {
    const username = req.params.username;
    const query = 'SELECT * FROM notifications WHERE username = ? ORDER BY created_at DESC';
    db.query(query, [username], (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil notifikasi' });
        res.json({ success: true, data: results });
    });
});

// Endpoint Ambil Daftar Psikolog
app.get('/api/psychologists', (req, res) => {
    const query = 'SELECT * FROM psychologists ORDER BY is_available DESC, rating DESC';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ success: false, message: 'Gagal mengambil data psikolog' });
        res.json({ success: true, data: results });
    });
});

// Fungsi Helper untuk Tambah Notifikasi
const addNotification = (username, title, message) => {
    const query = 'INSERT INTO notifications (username, title, message) VALUES (?, ?, ?)';
    db.query(query, [username, title, message], (err) => {
        if (err) console.error('Gagal mencatat notifikasi:', err);
    });
};

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
        addNotification(username, 'Laporan Terkirim', `Laporan kategori ${category} Anda telah kami terima.`);
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
            db.query('UPDATE users SET password = ? WHERE username = ?', [new_password, username], (err) => {
                if (err) return res.status(500).json({ success: false, message: 'Gagal mengubah password' });
                addNotification(username, 'Keamanan: Password Diubah', 'Kata sandi akun Anda baru saja diperbarui.');
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
        addNotification(username, 'Selamat Datang!', 'Terima kasih telah bergabung dengan SafeMind. Akun Anda telah siap digunakan.');
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
                addNotification(username, 'Login Baru', `Anda masuk melalui perangkat ${deviceName} (${ipAddress})`);
            });

            res.json({ success: true, message: 'Login berhasil', user: { ...user, role: user.role } });
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
        addNotification(username, 'Profil Diperbarui', 'Data profil dan identitas Anda telah berhasil diubah.');
        res.json({ success: true, message: 'Profil berhasil diperbarui' });
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});
