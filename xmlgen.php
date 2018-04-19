<?php

$titleregex = "^TITLE([^\n]*)";
$subtitleregex = "^SUBTITLE([^\n]*)";
$chapterregex = "^CHAPTER([^\n]*)";
$subchapterregex = "^SUBCHAPTER([^\n]*)";
$sectionregex = "^Sec([^\n]*)";
$actsregex = "^Acts([^\n]*)";

$dirs = [
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

foreach ($dirs as $dir) {

	if ($handle = opendir("BlueLineTX/$dir/htm/")) {

		while (false !== ($file = readdir($handle))) {
			if(($file != ".") and ($file != "..") and ($file != ".DS_Store")) {
				$files[] = $file;
			}   
		}

		$files[] = natsort($files);
		array_pop($files);

		foreach ($files as $file) {

			$curtitle = "";

			$html = file_get_contents("BlueLineTX/$dir/htm/$file");

			$dom = new DOMDocument();
			$dom->loadXML($html);

			$doc = new DOMDocument('1.0');
			$doc->formatOutput = true;

			$elements = $dom->getElementsByTagName('p');

			$textElements = array();

			foreach($elements as $node) {

	//title
				if (preg_match("/".$titleregex."/is", $node->nodeValue, $titlematch)) {
					if($curtitle != $titlematch[0]) {
						$curtitle = $titlematch[0];
						$title = $doc->createElement("title");
						$title = $doc->appendChild($title);
						$text = $doc->createTextNode($curtitle);
						$text = $title->appendChild($text);
					}
				} else {
					$title = $doc->createElement("remove");
					$title = $doc->appendChild($title);
				}
	//subtitle
				if (preg_match("/".$subtitleregex."/is", $node->nodeValue, $subtitlematch)) {
					foreach ($subtitlematch as $st) {
						if (preg_match("/".$subtitleregex."/is", $st, $subtitlematch)) {
							$cursubtitle = $subtitlematch[0];
							$subtitle = $doc->createElement("subtitle");
							$subtitle = $title->appendChild($subtitle);
							$text = $doc->createTextNode($cursubtitle);
							$text = $subtitle->appendChild($text);
						}
					}
				}
				else {
					$subtitle = $doc->createElement("remove");
					$subtitle = $title->appendChild($subtitle);
				}
	//chapter
				if (preg_match("/".$chapterregex."/is", $node->nodeValue, $chaptermatch)) {
					foreach ($chaptermatch as $c) {
						if (preg_match("/".$chapterregex."/is", $c, $chaptermatch)) {
							$curchapter = $chaptermatch[0];
							$chapter = $doc->createElement("chapter");
							$chapter = $subtitle->appendChild($chapter);
							$text = $doc->createTextNode($curchapter);
							$text = $chapter->appendChild($text);
						}
					}
				}
				else {
					$chapter = $doc->createElement("remove");
					$chapter = $subtitle->appendChild($chapter);
				}
	//subchapter
				if (preg_match("/".$subchapterregex."/is", $node->nodeValue, $subchaptermatch)) {
					foreach ($subchaptermatch as $sc) {
						if (preg_match("/".$subchapterregex."/is", $sc, $subchaptermatch)) {
							$cursubchapter = $subchaptermatch[0];
							$subchapter = $doc->createElement("subchapter");
							$subchapter = $chapter->appendChild($subchapter);
							$text = $doc->createTextNode($cursubchapter);
							$text = $subchapter->appendChild($text);
						}
					}
				}
				else {
					$subchapter = $doc->createElement("remove");
					$subchapter = $chapter->appendChild($subchapter);
				}
	//section
				if (preg_match("/".$sectionregex."/is", $node->nodeValue, $sectionmatch)) {
					foreach ($sectionmatch as $sec) {
						if (preg_match("/".$sectionregex."/is", $sec, $sectionmatch)) {
							$cursection = $sectionmatch[0];
							$section = $doc->createElement("section");
							$section = $subchapter->appendChild($section);
							$text = $doc->createTextNode($cursection);
							$text = $section->appendChild($text);
						}
					}
				}
				else {
					$section = $doc->createElement("remove");
					$section = $subchapter->appendChild($section);
				}
	//acts
				if (preg_match("/".$actsregex."/is", $node->nodeValue, $actsmatch)) {
					foreach ($actsmatch as $ac) {
						if (preg_match("/".$actsregex."/is", $ac, $actsmatch)) {
							$curacts = $actsmatch[0];
							$acts = $doc->createElement("acts");
							$acts = $section->appendChild($acts);
							$text = $doc->createTextNode($curacts);
							$text = $acts->appendChild($text);
						}
					}
				}
			}

			unset($files);
			if (!is_dir("BlueLineTX/$dir/xml/")) {
				mkdir("BlueLineTX/$dir/xml/");
			}
			file_put_contents("BlueLineTX/$dir/xml/".basename($file, ".htm").".xml",$doc->saveXML());
		}
	}
}
?>