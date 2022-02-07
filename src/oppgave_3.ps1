$kortstokk = Invoke-WebRequest -uri "http://nav-deckofcards.herokuapp.com/shuffle"
$kortstokk = $kortstokk.content | ConvertFrom-Json

#ConvertFrom-Json $kortstokk
#$json_kortstokk = ConvertFrom-Json $kortstokk

#Write-Output $kortstokk

#foreach ($kort in $kortstokk) {
#    Write-Output "$($kort.suit[0])$($kort.value)"
#}
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