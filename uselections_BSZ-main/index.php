<?php

require 'vendor/autoload.php';
require 'Model/USERepository.php';

$templates = new League\Plates\Engine('templates', 'tpl');
$year = '1976';

if(isset($_GET['year'])) {

    $year = $_GET['year'];

    $el_primo = Model\StudenteRepository::getElectionResults($year);

    $jsonContents = file_get_contents('states.json');
    $jsonArray = json_decode($jsonContents, true);

    foreach ($jsonArray['dataProvider']['areas'] as &$area) {
        $state_po = substr($area['id'], 3);
        foreach ($el_primo as $result) {
            if ($result[0] === $state_po) {
                if ($result[1] == 'REPUBLICAN') {
                    $area['showAsSelected'] = true;
                } else {
                    $area['showAsSelected'] = false;
                }
            }
        }
        unset($area);
    }
    $updatedJsonContents = json_encode($jsonArray, JSON_PRETTY_PRINT);
    file_put_contents('states.json', $updatedJsonContents);
}

$one_state_and_vote = null;
$filtred_state = null;

if(isset($_GET['state'])) {
    $filtred_state = $_GET['state'];
    $one_state_and_vote = \Model\StudenteRepository::getOneStateInfo_on_year($year, $_GET['state']);
}


$pres_and_vote = Model\StudenteRepository::getUsPresident($year);
$states_info = Model\StudenteRepository::getAllStatesInfo($year);
$list_of_states = Model\StudenteRepository::getNameState();
$vote_party = Model\StudenteRepository::getVote_Party_on_year($year);


$vector_image = [
    'Jimmy Carter' => "https://upload.wikimedia.org/wikipedia/commons/5/5a/JimmyCarterPortrait2.jpg",
    'Ronald Reagan' => "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Official_Portrait_of_President_Reagan_1981.jpg/479px-Official_Portrait_of_President_Reagan_1981.jpg",
    'George H. W. Bush' => "https://upload.wikimedia.org/wikipedia/commons/e/ee/George_H._W._Bush_presidential_portrait_%28cropped%29.jpg",
    'Bill Clinton' => "https://upload.wikimedia.org/wikipedia/commons/d/d3/Bill_Clinton.jpg",
    'George W. Bush' => "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/George-W-Bush.jpeg/453px-George-W-Bush.jpeg",
    'Barack Obama' => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg",
    'Donald Trump' => "https://upload.wikimedia.org/wikipedia/commons/5/56/Donald_Trump_official_portrait.jpg",
    'Joe Biden' => "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Joe_Biden_presidential_portrait.jpg/480px-Joe_Biden_presidential_portrait.jpg",
];


$presidenti = array(
    1976 => "Jimmy Carter",
    1980 => "Ronald Reagan",
    1984 => "Ronald Reagan",
    1988 => "George H. W. Bush",
    1992 => "Bill Clinton",
    1996 => "Bill Clinton",
    2000 => "George W. Bush",
    2004 => "George W. Bush",
    2008 => "Barack Obama",
    2012 => "Barack Obama",
    2016 => "Donald Trump",
    2020 => "Joe Biden"
);

$president = $presidenti[$year];
$imageUrl = $vector_image[$president];

echo $templates->render('mappa', [
    'pres_and_vote' => $pres_and_vote,
    'state_info' => $states_info,
    'imageUrl' => $imageUrl,
    'year' => $year,
    'list_of_states' => $list_of_states,
    'one_state_and_vote' => $one_state_and_vote,
    'filtred_state' => $filtred_state,
    'vote_party' => $vote_party,
    'president' => $president
]);
