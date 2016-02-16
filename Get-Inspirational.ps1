function Get-Inspired() {
    $APIurl = 'http://www.forismatic.com/api/1.0/'
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("Content-Type", "application/x-www-form-urlencoded")
    $client.Encoding = [System.Text.Encoding]::UTF8
    [xml]$quote = $client.UploadString($apiUrl, 'method=getQuote&lang=en&format=xml')
    $quoteFull = @("","")
    if([String]::IsNullOrEmpty($quote.forismatic.quote.quoteauthor)) {
        $quoteFull[0] = "Listen to this inspiration quote by Unknown author"
    }
    else {
        $quoteFull[0] = "Listen to this inspirational quote by " + $quote.forismatic.quote.quoteauthor 
    }
    $quoteFull[1] = $quote.forismatic.quote.quotetext
    
    Write-Output $quoteFull
}

Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

$speak.Rate = -3
$speak.Speak("Breathe in")
Sleep(2)
$speak.Speak("breathe out")
Sleep(1)

$i = 1
while ($true) {
    if(($i%5)-eq 0) {
        $speak.Rate = -3
        $speak.Speak("Now... Breathe in")
        Sleep(2)
        $speak.Speak("breathe out")
        Sleep(1)
    }
    $speak.Rate = -1
    $inspiration = Get-Inspired
    Write-Output $inspiration[0]        
    $speak.Speak($inspiration[0])
    Sleep(1)
    Write-Output $inspiration[1]
    $speak.Speak($inspiration[1])
    Sleep(1)

    $i++
}

