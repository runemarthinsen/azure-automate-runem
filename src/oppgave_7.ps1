param ($url_input)
#url å bruke: "http://nav-deckofcards.herokuapp.com/shuffle"
$ErrorActionPreference = 'Stop'

#satt input fra url til fast - kan også benytte $url_input for å kjøre script med input parameter
$kortstokk = Invoke-WebRequest -uri "http://nav-deckofcards.herokuapp.com/shuffle"
$kortstokk = $kortstokk.content | ConvertFrom-Json
$blackjack = 21

#legge foreach i funkjson - returnerer streng - siste karakter fjernes (,) vha substring
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
#summere kortstokk funksjon - vha switch
#unction sumPoengKortstokk {
#   [OutputType([int])]
#   param (
#       [object[]]
#       $kortstokk
#   )
#
#   $poengKortstokk = 0
#
#   foreach ($kort in $kortstokk) {
#       $poengKortstokk += switch ($kort.value) {
#           { $_ -cin @('J', 'Q' , 'K') } { 10 }
#           'A' { 11 }
#           default { $kort.value }
#       }
#   }
#   return $poengKortstokk
#
#funksjon definisjon med fore-each løkke
function sumpoengkortstokk {
    [OutputType([int])]
    param (
        [object[]]
        $kortstokk
    )
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
    return $poengkortstokk
}

# eks på for-each løkke beregne verdien i kortstokken
#$poengKortstokk = 0
#foreach ($kort in $kortstokk) {
#    if ($kort.value -ceq 'J' -or $kort.value -ceq 'Q' -or $kort.value -ceq 'K')  {
#        $poengKortstokk = $poengKortstokk + 10
#    }
#    elseif ($kort.value -ceq 'A') {
#        $poengKortstokk = $poengKortstokk + 11
#    }
#    else {
#        $poengKortstokk = $poengKortstokk + $kort.value
#    }
#}
#Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"

#mine kort - justerer kortstokken etterpå
$meg = $kortstokk[0..1]
$kortstokk = $kortstokk[2..$kortstokk.Count]
#magnus sine kort - justerer kortstokken etterpå
$magnus = $kortstokk[0..1]
$kortstokk = $kortstokk[2..$kortstokk.Count]
#lager variabel med poengsum med funksjon og input min/magnus sine kort
$minPoengsum = sumPoengKortstokk -kortstokk $meg
$magnusPoengsum = sumPoengKortstokk -kortstokk $magnus

#elseif for å sjekke hvem som vinner - evt 'uavgjort' hvis begge får 21 eller lik poengsum
if (($magnusPoengsum -eq $blackjack) -and ($minPoengsum -eq $blackjack)) {
    $vinner = "Uavgjort"
}
elseif ($minPoengsum -eq $blackjack) {
    $vinner = "meg"
}
elseif ($magnusPoengsum -eq $blackjack ) {
    $vinner = "Magnus"
}
elseif ($magnusPoengsum -eq $minPoengsum ) {
    $vinner = "Uavgjort"
}
elseif ($magnusPoengsum -ge $minPoengsum ) {
    $vinner = "Magnus"
}
elseif ($minpoengsum -ge $magnusPoengsum  ) {
    $vinner = "Meg"
}

#skriver ut resultat
Write-Output "Vinner: $vinner"
Write-Output "Meg    | $minpoengsum | $(kortstokkTilStreng -kortstokk $meg)"
Write-Output "Magnus | $magnuspoengsum | $(kortstokkTilStreng -kortstokk $magnus)"




