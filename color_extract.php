<?php

$url=$_SERVER['argv'][1];
if(empty($url)){
    die("Please add url param to GET request!");
}
include_once("colors.inc.php");
$ex=new GetMostCommonColors();
file_put_contents("temp.png",file_get_contents($url));
$colors=$ex->Get_Color("temp.png");
foreach ($colors as $color => $amount){
    if("$color" != "000000"){
        die("#$color");
    }
}