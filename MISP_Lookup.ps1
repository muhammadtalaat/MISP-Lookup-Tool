#MISP Lookup Tool V1.0#
 Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

function Execute-MISPLookup {
    if ([string]::IsNullOrWhiteSpace($csvPathTextBox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a TXT input file.")
        return
    }

    if ([string]::IsNullOrWhiteSpace($exportPathTextBox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a CSV export file path.")
        return
    }

    if ([string]::IsNullOrWhiteSpace($MISPAPITextBox.Text) -or [string]::IsNullOrWhiteSpace($MISPURLTextBox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter MISP API key and URL.")
        return
    }

    $MISPAPI = $MISPAPITextBox.Text
    $MISPURL = $MISPURLTextBox.Text

    $headers = @{
        "Authorization" = $MISPAPI
        "Accept" = "application/json"
        "Content-Type" = "application/json"
    }

    $ipList = Get-Content -Path $csvPathTextBox.Text
    $totalIPs = $ipList.Count
    $completedIPs = 0

    $results = @()

    $bulkCheck.Enabled = $false
    $outputProgress.Style = "Blocks"
    $outputProgress.Maximum = $totalIPs

    foreach ($ip in $ipList) {
        $completedIPs++

        $body = @{
            "returnFormat" = "csv"
            "value" = $ip
        } | ConvertTo-Json

        $response = Invoke-RestMethod -Uri "$MISPURL/events/restSearch" -Method POST -Headers $headers -Body $body -ContentType "application/json" -UseBasicParsing

        $responseObject = $response | ConvertFrom-Csv
        $results += $responseObject


        $outputProgress.Value = $completedIPs
        $progressLabel.Text = "Progress: $($completedIPs) / $($totalIPs)"
        $bulkChecker.Refresh()
    }

    $results | Export-Csv -Path $exportPathTextBox.Text -NoTypeInformation

    $bulkCheck.Enabled = $true  
    $outputProgress.Value = 0
    $progressLabel.Text = "Progress: 0 / $($totalIPs)"
    [System.Windows.Forms.MessageBox]::Show("Search completed. Results saved to $($exportPathTextBox.Text)")
}

function Show-MainWindow {
    $bulkChecker                     = New-Object system.Windows.Forms.Form
    $bulkChecker.ClientSize          = New-Object System.Drawing.Point(450, 600)
    $bulkChecker.text                = "MISP Lookup Tool"
    $bulkChecker.TopMost             = $false

    $Label1                          = New-Object system.Windows.Forms.Label
    $Label1.text                     = "MISP Lookup Tool"
    $Label1.AutoSize                 = $true
    $Label1.width                    = 25
    $Label1.height                   = 10
    $Label1.location                 = New-Object System.Drawing.Point(150, 22)
    $Label1.Font                     = New-Object System.Drawing.Font('Sylfaen',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $csvPathLabel                    = New-Object system.Windows.Forms.Label
    $csvPathLabel.text               = "TXT Input File Path / Name"
    $csvPathLabel.AutoSize           = $true
    $csvPathLabel.width              = 25
    $csvPathLabel.height             = 10
    $csvPathLabel.location           = New-Object System.Drawing.Point(25, 70)
    $csvPathLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $csvPathTextBox                  = New-Object system.Windows.Forms.TextBox
    $csvPathTextBox.multiline        = $false
    $csvPathTextBox.width            = 224
    $csvPathTextBox.height           = 20
    $csvPathTextBox.location         = New-Object System.Drawing.Point(22, 95)
    $csvPathTextBox.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $browseCsvPath                   = New-Object system.Windows.Forms.Button
    $browseCsvPath.text              = "Browse"
    $browseCsvPath.width             = 70
    $browseCsvPath.height            = 30
    $browseCsvPath.location          = New-Object System.Drawing.Point(263, 90)
    $browseCsvPath.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $browseCsvPath.Add_Click({
        $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openFileDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
        $openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
        $openFileDialog.ShowDialog() | Out-Null
        $csvPathTextBox.Text = $openFileDialog.FileName
    })

    $exportPathLabel                 = New-Object system.Windows.Forms.Label
    $exportPathLabel.text            = "CSV Export File Path / Name"
    $exportPathLabel.AutoSize        = $true
    $exportPathLabel.width           = 25
    $exportPathLabel.height          = 10
    $exportPathLabel.location        = New-Object System.Drawing.Point(23, 150)
    $exportPathLabel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $exportPathTextBox               = New-Object system.Windows.Forms.TextBox
    $exportPathTextBox.multiline     = $false
    $exportPathTextBox.width         = 225
    $exportPathTextBox.height        = 20
    $exportPathTextBox.location      = New-Object System.Drawing.Point(23, 175)
    $exportPathTextBox.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $browseExportPath                = New-Object system.Windows.Forms.Button
    $browseExportPath.text           = "Browse"
    $browseExportPath.width          = 70
    $browseExportPath.height         = 30
    $browseExportPath.location       = New-Object System.Drawing.Point(263, 170)
    $browseExportPath.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $browseExportPath.Add_Click({
        $saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
        $saveFileDialog.Filter = "CSV files (*.csv)|*.csv|All files (*.*)|*.*"
        $saveFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
        $saveFileDialog.ShowDialog() | Out-Null
        $exportPathTextBox.Text = $saveFileDialog.FileName
    })

    $MISPAPILabel                    = New-Object system.Windows.Forms.Label
    $MISPAPILabel.text               = "MISP API Key"
    $MISPAPILabel.AutoSize           = $true
    $MISPAPILabel.width              = 25
    $MISPAPILabel.height             = 10
    $MISPAPILabel.location           = New-Object System.Drawing.Point(25, 220)
    $MISPAPILabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $MISPAPITextBox                  = New-Object system.Windows.Forms.TextBox
    $MISPAPITextBox.multiline        = $false
    $MISPAPITextBox.width            = 350
    $MISPAPITextBox.height           = 20
    $MISPAPITextBox.location         = New-Object System.Drawing.Point(25, 245)
    $MISPAPITextBox.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $MISPURLLabel                    = New-Object system.Windows.Forms.Label
    $MISPURLLabel.text               = "MISP URL"
    $MISPURLLabel.AutoSize           = $true
    $MISPURLLabel.width              = 25
    $MISPURLLabel.height             = 10
    $MISPURLLabel.location           = New-Object System.Drawing.Point(25, 290)
    $MISPURLLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $MISPURLTextBox                  = New-Object system.Windows.Forms.TextBox
    $MISPURLTextBox.multiline        = $false
    $MISPURLTextBox.width            = 350
    $MISPURLTextBox.height           = 20
    $MISPURLTextBox.location         = New-Object System.Drawing.Point(25, 315)
    $MISPURLTextBox.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $bulkCheck                       = New-Object system.Windows.Forms.Button
    $bulkCheck.text                  = "Search"
    $bulkCheck.width                 = 175
    $bulkCheck.height                = 41
    $bulkCheck.location              = New-Object System.Drawing.Point(125, 360)
    $bulkCheck.Font                  = New-Object System.Drawing.Font('Franklin Gothic Book',16,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $bulkCheck.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")
    $bulkCheck.Add_Click({Execute-MISPLookup})

    $outputProgress                  = New-Object system.Windows.Forms.ProgressBar
    $outputProgress.width            = 300
    $outputProgress.height           = 30
    $outputProgress.location         = New-Object System.Drawing.Point(70, 420)

    $progressLabel                   = New-Object system.Windows.Forms.Label
    $progressLabel.text              = "Progress: 0 / 0"
    $progressLabel.AutoSize          = $true
    $progressLabel.width             = 25
    $progressLabel.height            = 10
    $progressLabel.location          = New-Object System.Drawing.Point(180, 470)
    $progressLabel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $bulkChecker.Controls.AddRange(@($Label1, $csvPathLabel, $csvPathTextBox, $browseCsvPath, $exportPathLabel, $exportPathTextBox, $browseExportPath, $MISPAPILabel, $MISPAPITextBox, $MISPURLLabel, $MISPURLTextBox, $bulkCheck, $outputProgress, $progressLabel))

    $bulkChecker.ShowDialog()
}

Show-MainWindow
