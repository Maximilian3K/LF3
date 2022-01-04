while ($true) {

#Eingabe der Attribute
$FirstName = Read-Host "Vorname"
$ErsterBuchstabe = Read-Host "Erster Buchstabe des Vornamens"
$Lastname = Read-Host "Nachname"


#Passwort generieren
$cof = Read-Host "Koplexes Passwort? (y/n)"

#Passwort Komplex
if ($cof -eq 'y') {
    $Password =@()
    $Password += [char[]] ([char]65..[char]90)
    $Password += [char[]] ([char]97..[char]122)
    $Password += 0..9
    $Password += [char[]] ([char]33..[char]38)
    $Password += [char[]] ([char]40..[char]47)

[int] $length = Read-Host -Prompt "Wieviele Zeichen lang?"
$generate = (Get-Random -InputObject $Password -Count $length) -join ""
Write-Host $generate
    }

#Passwort Inkomplex
    if ($cof -eq 'n') {
        $Password =@()
        $Password += [char[]] ([char]65..[char]90)
        $Password += [char[]] ([char]97..[char]122)
        $Password += 0..9
    
    [int] $length = Read-Host -Prompt "Wieviele Zeichen lang?"
    $generate = (Get-Random -InputObject $Password -Count $length) -join ""
    Write-Host $generate
        }


#Generate User
New-ADUser -Name "$FirstName $LastName" -GivenName "$FirstName" -Surname "$LastName" -SamAccountName "$ErsterBuchstabe.$Lastname" -AccountPassword (ConvertFrom-SecureString -AsPlainText "$generate" -force) -Enable $true


#Userdaten In Textdokument
$pfad = "C:\User\%User%\Desktop\"
for($i=0; $i -lt; $i++) {
New-Item -Path $pfad -ItemType file -Name "GeneratedUser.txt"}

Get-Command -Verb Format-List
$userdaten = $FirstName, $Lastname, "$ErsterBruchstabe.$Nachname", $generate
Add-Content -Path C:\User\%User%\Desktop\GeneratedUser.txt $userdaten

}


Read-SqlTableData -ServerInstance "127.0.0.1" -DatabaseName "UserDB" -SchemaName "dbo" -TableName "User" | get-ForEach-Object -Process if (get-date -format "yyyy/MM/dd") eq (ENDDATE) {
    Disable-ADAccount -Identity (%_)
}