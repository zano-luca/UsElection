<script src="https://www.amcharts.com/lib/3/ammap.js" type="text/javascript"></script>
<script src="https://www.amcharts.com/lib/3/maps/js/usaHigh.js" type="text/javascript"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js" type="text/javascript"></script>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=yes, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.8.0/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="icon" href="https://clipart-library.com/images/8i65pnkLT.jpg" type="image/x-icon">

    <title>Us Elections</title>

    <style>
        .center {
            display: flex;
            justify-content: center;
            text-align: center;
            align-items: center;
        }
        form{
            justify-content: normal;
        }
        .left {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            text-align: center;
            justify-content: center;
        }

        .right {
            width: 60%;
            text-align: center;
            justify-content: center;
            align-items: center;
        }

        .info {
            padding: 20px;
            width: 600px;
        }
        img{
            width: auto;
            height: 400px;
        }
        html{
            font-family: "Cascadia Mono";
            justify-items: center;
            text-align: center;
            align-items: center;
        }
        table{
            border: black 4px solid;
            max-width: calc(100% - 20px);
        }
        thead{
            background-color: #d2cdcd;
            font-weight: bold;
            font-size: 20px;

        }

        body {
            font-family: Arial, sans-serif;
            font-size: 16px;
            line-height: 1.5;
            margin: 0;
            padding: 0;
            background-color: #ffffff;

        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            box-sizing: border-box;
        }

        h1 {
            font-size: 20px;
            color: black;

        }

        p {
            font-size: 20px;
        }

        img {
            width: 300px;
            height: auto;
        }
        @media screen and (max-width: 768px) {
            h1 {
                font-size: 1.5em;
            }
        }

    </style>
</head>
<body>

    <div class="container">

        <div class="heading">
            <div style="border-radius: 10px; background-color: black; height: 90px; position: relative;" class="navbar bg-primary text-primary-content">
                <a href="../index.html"><button style="color: white" class="btn btn-ghost text-xl">Go back to presentation</button></a>

                <h1 style="text-align: center; color: white; font-size: 40px; position: absolute; left: 50%; transform: translateX(-50%);">US ELECTION</h1>

            </div>
        </div>
    </div>
    <br><br><br>


    <div class="center">
        <div class="left">
            <div id="mapdiv" style="width: 800px; height: 450px; margin-right: 20px; border: black 6px solid">Contenuto mappa</div>
        </div>

        <div class="right" style="text-align: center;">
            <p style="font-size: 30px;"> <strong>Percentage for every party</strong></p>
            <br>
            <div style="margin: 0 auto; width: fit-content;">

                <table class="table" style="text-align: center;">

                    <tr>
                        <th><strong>PARTY</strong></th>
                        <th><strong>PERCENTAGE</strong></th>
                    </tr>
                    
                    <tbody>
                    <?php foreach ($vote_party as $one) : ?>
                    <tr style="background-color: white; border: 2px solid black">
                        <td><strong><?php echo $one['party_simplified']; ?></strong></td>
                        <td><?php echo $one['percentuale_voti']; ?>%</td>
                    </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>


            </div>
        </div>

    </div>


    <div class="center">
        <div class="left">
            <div class="info">
                <h2 style="font-size: 30px;"> <strong>WINNER:</strong> <?php echo $president; ?></h2>
            </div>
            <img style="margin: 0 auto" src="<?php echo $imageUrl; ?>">
        </div>


        <div class="right">

            <table style="text-align: center; width: 600px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>
                <?php foreach ($pres_and_vote as $riga) : ?>
                <tr style="border: 2px solid black; background-color: white">
                    <th><?php echo $riga['candidate']; ?></th>
                    <th><?php echo $riga['VOTI']; ?></th>
                </tr>
                <?php endforeach; ?>
            </table>
        </div>
    </div>
    <br>
    <br>


    <form method="get" action="index.php">

        <select name="year" id="yearSelect" class="select select-primary max-w-xs">
            <option disabled selected>Select a year</option>

            <?php
                        $currentYear = date("Y");
                        $startYear = 1976;
                        $yearSelected = isset($_GET['year']) ? $_GET['year'] : '';
                        for ($year = $startYear; $year <= $currentYear - 4; $year += 4) {
                            $selected = ($year == $yearSelected) ? "selected" : "";
                            echo "<option value=\"$year\" $selected>$year</option>";
            }
            ?>
        </select>

        <select class="select select-primary w-full max-w-xs" name="state">
            <option disabled selected>Select a state</option>
            <option>All states</option>
            <?php foreach ($list_of_states as $state): ?>
            <option><?= $state["name"] ?></option>
            <?php endforeach; ?>
        </select>

        <input style="background-color: white" type="submit" value="Submit" class="btn btn-outline btn-primary">
    </form>


<div style="justify-content: center; align-items: center; text-align: center">

    <?php if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['state'])): ?>
    <?php
        $selected_state = $_GET['state'];

        if ($selected_state !== "All states"):
            ?>

    <div style="flex: 1;">
        <p> <strong>Filtred state: <?= $one_state_and_vote[0]["state"] ?> </strong></p>
        <p> <strong>Total votes: <?= $one_state_and_vote[0]["totalvotes"] ?> </strong></p>
        <br>
        <table style="text-align: center; margin: 0 auto; width: 900px;" class="table table-striped table-hover">
            <tr>
                <th> <strong> CANDIDATE </strong></th>
                <th> <strong> VOTE </strong> </th>
                <th> <strong> PARTY SIMPLIFIED </strong> </th>
                <th> <strong> PARTY DETAILED </strong> </th>
            </tr>
            <?php foreach ($one_state_and_vote as $state) : ?>
            <tr class="active">
                <td><?php echo $state['candidate']; ?></td>
                <td><?php echo $state['VOTI']; ?></td>
                <td><?php echo $state['party_simplified']; ?></td>
                <td><?php echo $state['party_detailed']; ?></td>

            </tr>
            <?php endforeach; ?>
        </table>
        <br>
    </div>
    <?php else: ?>
    <div style="display: flex; justify-content: space-between">

        <div style="flex: 1; text-align: center; align-items: center; justify-content: center">
            <?php for ($k = 0; $k < 17; $k++) : ?>

            <p>State: <strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>

            <table style="text-align: center; width: 400px; margin: 0 auto" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 17; $k < 34; $k++) : ?>
            <p>State:<strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>


            <table style="margin: 0 auto; text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 34; $k < 50; $k++) : ?>
            <p>State: <strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>

            <table style="text-align: center; width: 400px; margin: 0 auto" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
    </div>
    <?php endif; ?>

    <?php else: ?>
    <div style="display: flex; justify-content: space-between;">
        <div style="flex: 1;">
            <?php for ($k = 0; $k < 17; $k++) : ?>
            <p>State: <strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>

            <table style="text-align: center; width: 400px; margin-left: 20px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 17; $k < 34; $k++) : ?>
            <p>State: <strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>

            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
        <div style="flex: 1;">
            <?php for ($k = 34; $k < 50; $k++) : ?>
            <p>State: <strong><?php echo $state_info[$k*2]['state']; ?> </strong></p>

            <table style="text-align: center; width: 400px" class="table table-striped table-hover">
                <tr>
                    <th> <strong> CANDIDATE </strong></th>
                    <th> <strong> VOTE </strong> </th>
                </tr>

                <?php for ($i = 0; $i < 2; $i++) : ?>
                <?php $index = $i + $k * 2; ?>
                <?php if (isset($state_info[$index]['state'])) : ?>
                <tr class="active">
                    <td><?php echo $state_info[$index]['candidate']; ?></td>
                    <td><?php echo $state_info[$index]['VOTI']; ?></td>
                </tr>
                <?php else : ?>
                <?php break 2; ?>
                <?php endif; ?>
                <?php endfor; ?>
            </table>
            <br>
            <?php endfor; ?>
        </div>
    </div>
    <?php endif; ?>

</div>

</body>
</html>


<script type="text/javascript">
    var mapData = null;

    fetch('states.json')
        .then(response => response.json())
        .then(data => {
            mapData = data;
            createMap();
        })
        .catch(error => {
            console.error('Error loading map data:', error);
        });

    function createMap() {
        if (mapData) {
            var map = AmCharts.makeChart("mapdiv", mapData);
        }
    }

    function blue_or_red() {

    }
</script>