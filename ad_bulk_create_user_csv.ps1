# Import active directory module for PowerShell
Import-Module activedirectory
  
# Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv C:\ad_bulk_create_user_csv.csv

# parse the csv and store variables/attributes NEED TO TEST PASSWORD CHANGE PROCESS
foreach ($User in $ADUsers)
{
		
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$Username 	= $User.username
    $email      = $User.email
    $EmployeeID    = $User.EmployeeID
    $EmployeeNumber    = $User.EmployeeNumber
    $streetaddress = $User.streetaddress
    $city       = $User.city
    $zipcode    = $User.zipcode
    $state      = $User.state
    $country    = $User.country
    $password = $User.password
    $telephone  = $User.telephone
    $jobtitle   = $User.jobtitle
    $description    = $User.description
    $manager    = $User.manager
    $company    = $User.company
    $division    = $User.division
    $department = $User.department
    $office = $User.office
    $OU 		= $User.ou
	
    
    #Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 #If user does exist, give a warning
		 Write-Warning "A user account with username $Username already exist in Active Directory."
	}
	else
	{
		# User does not exist then proceed to create the new user account
		
        # Account will be created in the OU provided in the csv
		New-ADUser `
            -Name "$Firstname $Lastname" `
            -DisplayName "$Lastname, $Firstname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -SamAccountName $Username `
            -EmailAddress $email `
            -UserPrincipalName $email `
            -EmployeeID $EmployeeID `
            -EmployeeNumber $EmployeeNumber `
            -AccountPassword (convertTo-SecureString $password -AsPlainText -Force) `
            -ChangePasswordAtLogon:$true `
            -StreetAddress $streetaddress `
            -City $city `
            -postalCode $zipcode `
            -State $state `
            -country $country `
            -OfficePhone $telephone `
            -Title $jobtitle `
            -Description $description `
            -Manager $manager `
            -Company $company `
            -Division $division `
            -Department $department `
            -Office $office `
            -Path $OU `
            -Enabled $True `
            

	}
}
