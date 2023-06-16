<?php
// Configuración de la conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "316170040";
$dbname = "teamsoft";

// Obtener los datos del formulario
$nombre = $_POST['nombre'];
$numero_cuenta = $_POST['numero_cuenta'];
$email = $_POST['email'];

// Crear una conexión a la base de datos
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar si hay errores en la conexión
if ($conn->connect_error) {
    die("Error en la conexión: " . $conn->connect_error);
}

// Crear la consulta para insertar los datos en la base de datos
$sql = "INSERT INTO tabla_datos (nombre, numero_cuenta, email) VALUES ('$nombre', '$numero_cuenta', '$email')";

// Ejecutar la consulta
if ($conn->query($sql) === TRUE) {
    echo "Datos guardados correctamente";
} else {
    echo "Error al guardar los datos: " . $conn->error;
}

// Cerrar la conexión a la base de datos
$conn->close();
?>

