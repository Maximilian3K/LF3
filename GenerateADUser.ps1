while ($true) {

$ConfigEing = Read-Host "User erstellen (e)/ User Gruppen aendern (g)/ User Deaktivieren (d)?"

if ($ConfigEing -eq 'e'){

#Eingabe der Attribute
$FirstName = Read-Host "Vorname:"
$Lastname = Read-Host "Nachname:"

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
New-ADUser -Name "$FirstName $LastName" -GivenName "$FirstName" -Surname "$LastName" -SamAccountName "$FirstName.$Lastname" -EmailAddress ($_.givenName + '.' + $_.surname + '@test.net') -AccountPassword (ConvertFrom-SecureString -AsSecureString "$generate" -force) -Enable $true


    if ($Group -eq 'Admin') {
    Add-ADGroupMember -Identity AdminGroup -Members "$FirstName.$Nachname"
    Add-ADGroupMember -Identity LeaderGroup -Members "$FirstName.$Nachname"
    Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}
    
    
    if ($Group -eq 'Leader') {
    Add-ADGroupMember -Identity LeaderGroup -Members "$FirstName.$Nachname"
    Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}
    
    if ($Group -eq 'Member') {
    Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}
      


#Userdaten In Textdokument
$pfad = "C:\User\%User%\Desktop\"
for($i=0; $i -lt $i++) {
New-Item -Path $pfad -ItemType file -Name "GeneratedUser.txt"}

Get-Command -Verb Format-List
$userdaten = $FirstName, $Lastname, "$FirstName.$Nachname", $generate, $Group
Add-Content -Path C:\User\%User%\Desktop\GeneratedUser.txt $userdaten
}




if ($ConfigEing -eq 'g') {

$Group = Read-Host "Welche Nutzergruppe? (Admin/Leader/Member)"

$FirstName = Read-Host "Vorname:"
$Lastname = Read-Host "Nachname:"

if ($Group -eq 'Admin') {
Add-ADGroupMember -Identity AdminGroup -Members "$FirstName.$Nachname"
Add-ADGroupMember -Identity SuperadminGroup -Members "$FirstName.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}


if ($Group -eq 'Leader') {
Add-ADGroupMember -Identity LeaderGroup -Members "$FirstName.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"
Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}

if ($Group -eq 'Member') {
Add-ADGroupMember -Identity MemberGroup -Members "$FirstName.$Nachname"}
}




if ($ConfigEing -eq 'd') {
$FirstName = Read-Host "Vorname:"
$Lastname = Read-Host "Nachname:"

Disable-ADAccount -Identity "$FirstName.$Nachname"
}



}
