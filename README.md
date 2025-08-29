// BAD PRACTICE
const express = require('express');
const mysql = require('mysql2');
const app = express();

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'test'
});

app.get('/user', (req, res) => {
  const userId = req.query.id;
  const query = `SELECT * FROM users WHERE id = ${userId}`; // Vulnerable!
  connection.query(query, (err, results) => {
    if (err) throw err;
    res.send(results);
  });
});

app.listen(3000);




                    // Timeout de 30 segundos
                    timeout(time: 30, unit: 'SECONDS') {
                        echo "Opción seleccionada: ${userChoice}"
                    }
