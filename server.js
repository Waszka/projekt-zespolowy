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


app.get('/api/arduino', (req, res) => {
    const sql = `SELECT * FROM arduino`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        } else {
            res.status(200).json(result);
        }
    });

});

app.get('/api/temp/:arduinoId', (req, res) => {
    const arduinoId = req.params.arduinoId;
    const sql = `SELECT * FROM temp WHERE arduino_id = '${arduinoId}' ORDER BY datetime DESC LIMIT 1`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        } else if (result.length === 0) {
            res.status(404).json({error: 'Not found'});
        } else {
            res.status(200).json(result);
        }
    });

});

app.get('/api/noise/:arduinoId', (req, res) => {
    const arduinoId = req.params.arduinoId;
    const sql = `SELECT * FROM noise WHERE arduino_id = '${arduinoId}' ORDER BY datetime DESC LIMIT 1`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        } else if (result.length === 0) {
            res.status(404).json({error: 'Not found'});
        } else {
            res.status(200).json(result);
        }
    });

});

app.get('/api/camera/:arduinoId', (req, res) => {
    const arduinoId = req.params.arduinoId;
    const sql = `SELECT * FROM camera WHERE arduino_id = '${arduinoId}'`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        } else if (result.length === 0) {
            res.status(404).json({error: 'Not found'});
        } else {
            res.status(200).json(result);
        }
    });

});

app.get('/api/allArduino', (req, res) => {
    const sql = `SELECT arduino.*, temp.temperature, temp.humidity, noise.noiseLevel
FROM arduino
LEFT JOIN (
  SELECT arduino_id, temperature, humidity
  FROM temp
  WHERE datetime = (
    SELECT MAX(datetime)
    FROM temp
    WHERE temp.arduino_id = arduino_id
  )
) AS temp ON arduino.arduino_id = temp.arduino_id
LEFT JOIN (
  SELECT arduino_id, noiseLevel
  FROM noise
  WHERE datetime = (
    SELECT MAX(datetime)
    FROM noise
    WHERE noise.arduino_id = arduino_id
  )
) AS noise ON arduino.arduino_id = noise.arduino_id;
`;

    // Wykonanie zapytania do bazy danych
    connection.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({error: err.message});
        }else {
            console.log(result);
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