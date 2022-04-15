<?php

$url=$_SERVER['argv'][1];
if(empty($url)){
    die("Please add url param to GET request!");
}
include_once("colors.inc.php");
$ex=new GetMostCommonColors();
$expUrl = explode(".",$url);
$tmpName = "temp.".$expUrl[count($expUrl)-1];
file_put_contents($tmpName,file_get_contents($url));
$colors=$ex->Get_Color($tmpName);
foreach ($colors as $color => $amount){
    if("$color" != "000000"){
        unlink($tmpName);
        die("#$color");
    }
}