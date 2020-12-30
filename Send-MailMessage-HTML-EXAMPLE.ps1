

$sender         = "noreply@example.com"
$password       = ConvertTo-SecureString 'password' -AsPlainText -Force
$office365Creds = New-Object System.Management.Automation.PSCredential ($sender, $password)

$recipients = @(
    "user1@example.com"
)

$recipientsCc = @(
    "user2@example.com"
)

$recipientsBcc = @(
    "user3@example.com"
)

$body = @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body style="background-color: blue;color: white;">
  <h1>Test</h1>
</body>
</html>
'@

$params = @{
    SmtpServer                 = 'smtp.office365.com'
    Port                       = '587'
    UseSSL                     = $true
    BodyAsHtml                 = $true
    Encoding                   = 'utf8'
    Credential                 = $office365Creds
    From                       = $sender
    To                         = $recipients
    Cc                         = $recipientsCc
    Bcc                        = $recipientsBcc
    Subject                    = "Test - $(Get-Date -Format g)"
    Body                       = $body
    DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
}

Send-MailMessage @params