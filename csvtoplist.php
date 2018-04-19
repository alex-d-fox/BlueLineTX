<?php
ini_set("auto_detect_line_endings", true); 
$file = "fwcitations.csv";
$output = array();
array_push($output, "<?xml version='1.0' encoding='UTF-8'?>\n");
array_push($output, "<!DOCTYPE plist PUBLIC '-//Apple//DTD PLIST 1.0//EN' 'http://www.apple.com/DTDs/PropertyList-1.0.dtd'>\n");
array_push($output, "<plist version='1.0'>\n");
array_push($output, "	<array>\n");
if (($handle = fopen($file, "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $num = count($data);
        for ($c=0; $c < $num; $c++) {
        	if ($c % 2 == 0) {
        		array_push($output, "		<array>\n");
        		array_push($output, "			<string>" . $data[$c] . "</string>\n");
        	}
            if ($c % 2 == 1) {
            	array_push($output, "			<string>" . htmlentities($data[$c]) . "</string>\n");
        		array_push($output, "		</array>\n");
        	}
        }
    }
    fclose($handle);
}
array_push($output, "	</array>\n");
array_push($output, "</plist>\n");
file_put_contents("fwcitations.plist",$output);
print_r($output);
?>