while ($true) {

$ConfigEing = Read-Host "User erstellen (e)/ User Gruppen aendern (g)/ User Deaktivieren (d)?"

if ($ConfigEing -eq 'e'){

#Eingabe der Attribute
$FirstName = Read-Host "Vorname"
$ErsterBuchstabe = Read-Host "Erster Buchstabe des Vornamens"
$Lastname = Read-Host "Nachname"

$cof = Read-Host "Koplexes Passwort? (y/n)"
$Group = Read-Host "Welche Nutzergruppe? (Admin/Leader/Member)"

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
New-ADUser -Name "$FirstName $LastName" -GivenName "$FirstName" -Surname "$LastName" -SamAccountName "$ErsterBuchstabe.$Lastname" -EmailAddress ($_.givenName + '.' + $_.surname + '@test.net') -AccountPassword (ConvertFrom-SecureString -AsSecureString "$generate" -force) -Enable $true

#Userdaten In Textdokument
$pfad = "C:\User\%User%\Desktop\"
for($i=0; $i -lt $i++) {
New-Item -Path $pfad -ItemType file -Name "GeneratedUser.txt"}

Get-Command -Verb Format-List
$userdaten = $FirstName, $Lastname, "$ErsterBruchstabe.$Nachname", $generate, $Group
Add-Content -Path C:\User\%User%\Desktop\GeneratedUser.txt $userdaten
}




if ($ConfigEing -eq 'g') {
$ErsterBuchstabe = Read-Host "Erster Buchstabe des Vornamens"
$Lastname = Read-Host "Nachname"

if ($Group -eq 'Admin') {
Add-ADGroupMember -Identity AdminGroup -Members "$ErsterBruchstabe.$Nachname"
Add-ADGroupMember -Identity SuperadminGroup -Members "$ErsterBruchstabe.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$ErsterBruchstabe.$Nachname"}


if ($Group -eq 'Leader') {
Add-ADGroupMember -Identity LeaderGroup -Members "$ErsterBruchstabe.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$ErsterBruchstabe.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$ErsterBruchstabe.$Nachname"}

if ($Group -eq 'Member') {
Add-ADGroupMember -Identity MemberGroup -Members "$ErsterBruchstabe.$Nachname"}
}




if ($ConfigEing -eq 'd') {
$ErsterBuchstabe = Read-Host "Erster Buchstabe des Vornamens"
$Lastname = Read-Host "Nachname"

Disable-ADAccount -Identity "$ErsterBruchstabe.$Nachname"
}



}
