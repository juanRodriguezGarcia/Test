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
currentBuild.result = 'ABORTED'




pipeline {
    agent any

    stages {
        stage('Seleccionar opción') {
            steps {
                script {
                    try {
                        // Timeout aplica al input, no al echo
                        def userChoice = timeout(time: 30, unit: 'SECONDS') {
                            input(
                                id: 'userInput', 
                                message: 'Escoge una opción', 
                                parameters: [
                                    [$class: 'ChoiceParameterDefinition',
                                     choices: "Opción 1\nOpción 2\nTerminar",
                                     name: 'OPCION']
                                ]
                            )
                        }
                        echo "Opción seleccionada: ${userChoice}"
                    } catch(err) {
                        // Timeout o cancelación
                        echo "No se seleccionó opción a tiempo. Se ejecuta Opción 1 por defecto."
                        userChoice = 'Opción 1'
                    }

                    // Ejecutar según opción
                    if (userChoice == 'Opción 1') {
                        echo "Ejecutando opción 1"
                    } else if (userChoice == 'Opción 2') {
                        echo "Ejecutando opción 2"
                    } else if (userChoice == 'Terminar') {
                        echo "Terminando job"
                        currentBuild.result = 'ABORTED'
                        error('Job terminado por opción seleccionada')
                    }
                }
            }
        }
    }
}

