const express = require('express');
const mysql = require('mysql2');
const dotenv = require('dotenv');
const cors = require('cors');

dotenv.config();

const app = express();
app.use(cors());
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
        console.error('Detail:', err);
        return;
    }
    console.log('✅ Terhubung ke database MySQL: ' + process.env.DB_NAME);
});

app.get('/', (req, res) => {
    res.send('SafeMind Backend API is running...');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});
