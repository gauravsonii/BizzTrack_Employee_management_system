const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// MySQL connection pool
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'ur sql password', // Your provided MySQL password
    database: 'bizztrack_new',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// List of tables (excluding leavess)
const tables = [
    'asset', 'attendance', 'benefit', 'client', 'department', 'employee',
    'location', 'payroll', 'project', 'role', 'task', 'team', 'training'
];

// Generic CRUD routes for all tables
tables.forEach(table => {
    // Get all records
    app.get(`/api/${table}`, async (req, res) => {
        try {
            const [rows] = await pool.query(`SELECT * FROM ${table}`);
            res.json(rows);
        } catch (error) {
            console.error(`Error fetching from ${table}:`, error);
            res.status(500).json({ error: 'Database error' });
        }
    });

    // Get single record by ID
    app.get(`/api/${table}/:id`, async (req, res) => {
        try {
            const idField = table === 'department' ? 'dept_id' : `${table}_id`;
            const [rows] = await pool.query(`SELECT * FROM ${table} WHERE ${idField} = ?`, [req.params.id]);
            if (rows.length === 0) {
                return res.status(404).json({ error: `${table} record not found` });
            }
            res.json(rows[0]);
        } catch (error) {
            console.error(`Error fetching from ${table}:`, error);
            res.status(500).json({ error: 'Database error' });
        }
    });

    // Create record
    app.post(`/api/${table}`, async (req, res) => {
        try {
            // Replace 'bonous' with 'bonus' for payroll table
            if (table === 'payroll') {
                if (req.body.bonous !== undefined) {
                    req.body.bonus = req.body.bonous;
                    delete req.body.bonous;
                }
            }
            const fields = Object.keys(req.body).filter(key => req.body[key] !== null && key !== `${table}_id`);
            if (fields.length === 0) {
                return res.status(400).json({ error: 'No valid fields provided' });
            }
            const values = fields.map(key => req.body[key]);
            const placeholders = fields.map(() => '?').join(', ');
            const [result] = await pool.query(`INSERT INTO ${table} (${fields.join(', ')}) VALUES (${placeholders})`, values);
            res.status(201).json({ message: 'Record created', id: result.insertId });
        } catch (error) {
            console.error(`Error creating in ${table}:`, error);
            res.status(500).json({ error: 'Database error' });
        }
    });

    // Update record
    app.put(`/api/${table}/:id`, async (req, res) => {
        try {
            // Replace 'bonous' with 'bonus' for payroll table
            if (table === 'payroll') {
                if (req.body.bonous !== undefined) {
                    req.body.bonus = req.body.bonous;
                    delete req.body.bonous;
                }
            }
            const fields = Object.keys(req.body).filter(key => key !== `${table}_id` && req.body[key] !== null);
            if (fields.length === 0) {
                return res.status(400).json({ error: 'No valid fields provided' });
            }
            const values = fields.map(key => req.body[key]);
            const idField = table === 'department' ? 'dept_id' : `${table}_id`;
            const setClause = fields.map(key => `${key} = ?`).join(', ');
            const [result] = await pool.query(`UPDATE ${table} SET ${setClause} WHERE ${idField} = ?`, [...values, req.params.id]);
            if (result.affectedRows === 0) {
                return res.status(404).json({ error: `${table} record not found` });
            }
            res.json({ message: 'Record updated' });
        } catch (error) {
            console.error(`Error updating in ${table}:`, error);
            res.status(500).json({ error: 'Database error' });
        }
    });

    // Delete record
    app.delete(`/api/${table}/:id`, async (req, res) => {
        try {
            const idField = table === 'department' ? 'dept_id' : `${table}_id`;
            const [result] = await pool.query(`DELETE FROM ${table} WHERE ${idField} = ?`, [req.params.id]);
            if (result.affectedRows === 0) {
                return res.status(404).json({ error: `${table} record not found` });
            }
            res.json({ message: 'Record deleted' });
        } catch (error) {
            console.error(`Error deleting from ${table}:`, error);
            res.status(500).json({ error: 'Database error' });
        }
    });
});

// Start the server
app.listen(5000, () => {
    console.log('Server running on http://localhost:5000');
});
