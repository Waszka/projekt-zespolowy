<?php
class dht11
{
    public $link = '';

    function __construct($arduino_id, $temp, $temperature, $humidity)
    {
        $this->connect();
        $this->storeInDB($arduino_id, $temp, $temperature, $humidity);
    }

    function connect()
    {
        $this->link = mysqli_connect('localhost', 'root', '') or die('Cannot connect to the DB');
        mysqli_select_db($this->link, 'projektzespolowy') or die('Cannot select the DB');
    }

    function storeInDB($arduino_id, $temp, $temperature, $humidity)
    {
        // Sprawdzenie, czy istnieje już rekord dla danego arduino
        $query = "SELECT * FROM arduino WHERE arduino_id = '$arduino_id'";
        $result = mysqli_query($this->link, $query) or die('Errant query:  ' . $query);

        if (mysqli_num_rows($result) == 1) {
            $query = "INSERT INTO `temp`(`arduino_id`, `temperature`, `humidity`) VALUES ('" . mysqli_real_escape_string($this->link, $arduino_id) . "','" . mysqli_real_escape_string($this->link, $temperature) . "','" . mysqli_real_escape_string($this->link, $humidity) . "')";
            $result = mysqli_query($this->link, $query) or die('Errant query:  ' . $query);
        } else {
            // Dodanie nowego rekordu do tabeli temp
            $query = "INSERT INTO `arduino`(`arduino_id`, `temp`,`name`, `status`) VALUES ('" . mysqli_real_escape_string($this->link, $arduino_id) . "','" . mysqli_real_escape_string($this->link, $temp) . "','Hala 1','1')";
            $result = mysqli_query($this->link, $query) or die('Errant query:  ' . $query);
        }
    }
}

if($_GET['arduino_id'] != '' and  $_GET['temp'] != ''
    and  $_GET['temperature'] != ''
    and  $_GET['humidity'] != ''){
    $dht11=new dht11($_GET['arduino_id'],$_GET['temp'], $_GET['temperature'],$_GET['humidity']);
}
