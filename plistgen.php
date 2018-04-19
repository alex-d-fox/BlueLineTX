<?php
$array = [
"AgricultureCode",

"AuxWaterLaws",

"AlcoholicBeveragesCode",

"BizComCode",

"BusinessOrgCode",

"CivilPracticeandRemediesCode",

"CriminalProcedureCode",

"EducationCode",

"ElectionCode",

"EstatesCode",

"FamilyCode",

"FinanceCode",

"GovernmentCode",

"HealthSafetyCode",

"HumanResourcesCode",

"InsuranceCode",

"InsuranceNotCodifiedCode",

"LaborCode",

"LocalGovernmentCode",

"NaturalResourcesCode",

"OccupationsCode",

"ParksAndWildlifeCode",

"PenalCode",

"PropertyCode",

"SpecialDistrictLocalLawsCode",

"TaxCode",

"TrafficCode",

"UtilitiesCode",

"WaterCode"
];

foreach ($array as $key) {
unset($files);
$files = array();
$data = array();
array_push($data, "<?xml version='1.0' encoding='UTF-8'?>\n");
array_push($data, "<!DOCTYPE plist PUBLIC '-//Apple//DTD PLIST 1.0//EN' 'http://www.apple.com/DTDs/PropertyList-1.0.dtd'>\n");
array_push($data, "<plist version='1.0'>\n");
array_push($data, "<array>\n");

if ($handle = opendir("BlueLineTX/$key/htm/")) {

	while (false !== ($file = readdir($handle))) {
		if(($file != ".") and ($file != "..") and ($file != ".DS_Store")) {
                $files[] = $file; // put in array.
        }   
	}

        $files[] = natsort($files);
		$word1="";
		$oldword1="";
		foreach($files as $file) {
			if ($file !="1") {
				$txt = file_get_contents("BlueLineTX/$key/htm/$file");
			}
			$reg1='TITLE \d+. ([^<]*)';

			if ($c=preg_match ("/".$reg1."/is", $txt, $match1)) {
				if($word1 != $match1[0]) {
					$word1 = $match1[0];
					array_push($data, "	</array>\n");
					array_push($data, "	<array>\n");
					array_push($data, "		<string>$word1</string>\n");
				}
				$reg2='CHAPTER \d+[a-z]?. ([^<]*)';

				if ($c=preg_match ("/".$reg2."/is", $txt, $match2))
				{
					$word2=$match2[1];
					$file=substr($file, 3);
					$file=substr($file, 0, -4);
					if ($file != "") {
						array_push($data, "		<array>\n");
						array_push($data, "			<string>$file</string>\n");
						array_push($data, "			<string>$word2</string>\n");
						array_push($data, "		</array>\n");
					}
				}
			 }

		}
			 	array_push($data,"	</array>\n");
				array_push($data, "</array>\n");
				array_push($data, "</plist>\n");
				unset($data[4]);
	closedir($handle);
}
	file_put_contents("BlueLineTX/$key/plist/$key.plist",$data);
}
?>