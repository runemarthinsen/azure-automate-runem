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


Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"