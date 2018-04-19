<?php

$titleregex = "^TITLE([^\n]*)";
$subtitleregex = "^SUBTITLE([^\n]*)";
$chapterregex = "^CHAPTER([^\n]*)";
$subchapterregex = "^SUBCHAPTER([^\n]*)";
$sectionregex = "^Sec([^\n]*)";
$actsregex = "^Acts([^\n]*)";

$dirs = [
// array("AgricultureCode"),

array("AuxWaterLaws"),

// array("AlcoholicBeveragesCode"),

// array("BizComCode"),

// array("BusinessOrgCode"),

// array("CivilPracticeandRemediesCode"),

// array("CriminalProcedureCode"),

// array("EducationCode"),

// array("ElectionCode"),

// array("EstatesCode"),

// array("FamilyCode"),

// array("FinanceCode"),

// array("GovernmentCode"),

// array("HealthSafetyCode"),

// array("HumanResourcesCode"),

// array("InsuranceCode"),

// array("InsuranceNotCodifiedCode"),

// array("LaborCode"),

// array("LocalGovernmentCode"),

// array("NaturalResourcesCode"),

// array("OccupationsCode"),

// array("ParksAndWildlifeCode"),

// array("PenalCode"),

// array("PropertyCode"),

// array("SpecialDistrictLocalLawsCode"),

// array("TaxCode"),

// array("TrafficCode"),

// array("UtilitiesCode"),

// array("WaterCode")
];
$curtitle = $cursubtitle = $curchapter = $cursubchapter = $cursection = $curacts = $data = "";
foreach ($dirs as &$dir) {
	if ($handle = opendir("BlueLineTX/$dir[0]/htm/")) {

		while (false !== ($file = readdir($handle))) {
			if(($file != ".") and ($file != "..") and ($file != ".DS_Store")) {
				$files[] = $file;
			}   
		}

		$files[] = natsort($files);
		array_pop($files);

		foreach ($files as &$file) {
			$html = file_get_contents("BlueLineTX/$dir[0]/htm/$file");

			$dom = new DOMDocument();
			$dom->loadXML($html);

			$elements = $dom->getElementsByTagName('p');

			foreach($elements as $node) {
//title
				if (preg_match("/".$titleregex."/is", $node->nodeValue, $titlematch)) {
					if($curtitle != $titlematch[0]) {
						$curtitle = $titlematch[0];
						$dir[$dir[0]][] = $curtitle;
					}
				}
//subtitle
				if (preg_match("/".$subtitleregex."/is", $node->nodeValue, $subtitlematch)) {
					if($cursubtitle != $subtitlematch[0]) {
						$cursubtitle = $subtitlematch[0];
						$dir[$dir[0]][$curtitle][] = $cursubtitle;
					}
				}
//chapter
				if (preg_match("/".$chapterregex."/is", $node->nodeValue, $chaptermatch)) {
					if($curchapter != $chaptermatch[0]) {
						$curchapter = $chaptermatch[0];
						$dir[$dir[0]][$curtitle][$cursubtitle][] = $curchapter;
					}
				}
//subchapter
				if (preg_match("/".$subchapterregex."/is", $node->nodeValue, $subchaptermatch)) {
					if($cursubchapter != $subchaptermatch[0]) {
						$cursubchapter = $subchaptermatch[0];
						$dir[$dir[0]][$curtitle][$cursubtitle][$curchapter][] = $cursubchapter;
					}
				}
//section
				if (preg_match("/".$sectionregex."/is", $node->nodeValue, $sectionmatch)) {
					if($cursection != $sectionmatch[0]) {
						$cursection = $sectionmatch[0];
						$dir[$dir[0]][$curtitle][$cursubtitle][$curchapter][$cursubchapter][] = $cursection;
					}
				}
//acts
				if (preg_match("/".$actsregex."/is", $node->nodeValue, $actsmatch)) {
					if($curacts != $actsmatch[0]) {
						$curacts = $actsmatch[0];
						$dir[$dir[0]][$curtitle][$cursubtitle][$curchapter][$cursubchapter][$cursection][] = $curacts;
					}
				}

				unset($files);
			}
		}
	}
}
echo json_encode($dirs);
// file_put_contents("array.json", json_encode($dirs));
?>