param ($url_input)
#url å bruke: "http://nav-deckofcards.herokuapp.com/shuffle"
$ErrorActionPreference = 'Stop'

$kortstokk = Invoke-WebRequest -uri $url_input
$kortstokk = $kortstokk.content | ConvertFrom-Json

#legge foreach i funkjson - returnerer streng - siste karakter vha substring
function kortstokkTilStreng {
    [OutputType([string])]
    param (
        [object[]]
        $kortstokk
    )
    $streng = ""
    foreach ($kort in $kortstokk) {
        $streng = $streng + "$($kort.suit[0])" + $($kort.value) + ","
    }
    return $streng = $streng.Substring(0,$streng.Length-1)
}
$poengKortstokk = 0
foreach ($kort in $kortstokk) {
    if ($kort.value -ceq 'J' -or $kort.value -ceq 'Q' -or $kort.value -ceq 'K')  {
        $poengKortstokk = $poengKortstokk + 10
    }
    elseif ($kort.value -ceq 'A') {
        $poengKortstokk = $poengKortstokk + 11
    }
    else {
        $poengKortstokk = $poengKortstokk + $kort.value
    }
}
Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"

$meg = $(kortstokktilstreng -kortstokk $kortstokk[0..1])
$kortstokk = $kortstokk[2..$kortstokk.count]
$magnus =$(kortstokktilstreng -kortstokk $kortstokk[0..1])
$kortstokk = $kortstokk[2..$kortstokk.count]

Write-Output "Poengsum: $poengkortstokk"
Write-Output "Mine kort: $meg"
Write-Output "Magnus sine kort: $magnus"
Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"