<?php

$url=$_SERVER['argv'][1];
if(empty($url)){
    die("Please add url param to GET request!");
}
$imageData = getColorPallet($url);
foreach ($imageData as $clr){
    if(strlen("$clr") == 6){
        die("#$clr");
    }
}
function getColorPallet($imageURL, $palletSize=[16,8]){ // GET PALLET FROM IMAGE PLAY WITH INPUT PALLET SIZE
    // SIMPLE CHECK INPUT VALUES
    if(!$imageURL) return false;

    // IN THIS EXEMPLE WE CREATE PALLET FROM JPG IMAGE
    $img = null;
    $urlPars = explode(".",$imageURL);
    $extension = strtolower($urlPars[count($urlPars)-1]);
    if($extension == "png"){
        $img = imagecreatefrompng($imageURL);
    }elseif($extension == "jpg" || $extension == "jpeg"){
        $img = imagecreatefromjpeg($imageURL);
    }elseif($extension == "webp"){
        $img = imagecreatefromwebp($imageURL);
    }

    // SCALE DOWN IMAGE
    $imgSizes=getimagesize($imageURL);

    $resizedImg=imagecreatetruecolor($palletSize[0],$palletSize[1]);

    imagecopyresized($resizedImg, $img , 0, 0 , 0, 0, $palletSize[0], $palletSize[1], $imgSizes[0], $imgSizes[1]);

    imagedestroy($img);

    //GET COLORS IN ARRAY
    $colors=[];

    for($i=0;$i<$palletSize[1];$i++)
        for($j=0;$j<$palletSize[0];$j++)
            $colors[]=dechex(imagecolorat($resizedImg,$j,$i));

    imagedestroy($resizedImg);

    return array_unique($colors);

}
?>