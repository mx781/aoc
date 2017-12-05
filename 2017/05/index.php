<?php

  $file = "input.txt";
  $part = 2;

  $fh = fopen($file, "r");
  $input = fread($fh, filesize($file));
  
  $list = explode("\n", $input);
  $list = array_map(function($val){
    return (int)$val;
  }, $list);
  array_pop($list);

  $position = 0;
  $steps = 0;
  $complete = false;
  while(!$complete) {
    $offset = $list[$position];
    if($part == 1)
      $list[$position]++;
    else {
      if($offset >= 3)
        $list[$position]--;
      else
        $list[$position]++;
    }
    $position += $offset;
    $steps++;
    if(!isset($list[$position]))
      $complete = true;
  }

  var_dump($steps);
?>