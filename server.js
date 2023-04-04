const express = require('express');
const app = express();
const cors = require('cors')
const mysql = require('mysql');
const bodyParser = require('body-parser');

const port = 3000;

app.use(bodyParser.json());
app.use(cors());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'projektzespolowy',
    multipleStatements: true
});

connection.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('Połączono z bazą danych MySQL');
});



app.get('/api/temp', (req, res) => {
    const sql = `SELECT * FROM ims ORDER BY datetime DESC LIMIT 1`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        }else {
            res.status(200).json(result);
        }
    });

});







// Obsługa nieznanych adresów URL
app.use((req, res) => {
    res.status(404).json({error: 'Nie znaleziono żądanego zasobu'});
});

// Obsługa błędów
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({error: 'Wewnętrzny błąd serwera'});
});

app.listen(port, () => {
    console.log(`Api dziala na porcie ${port}`);
});