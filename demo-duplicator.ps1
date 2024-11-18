
function Show-Banner {
    $banner = @"
'########::'########:'##::::'##::'#######::                                                           
 ##.... ##: ##.....:: ###::'###:'##.... ##:                                                           
 ##:::: ##: ##::::::: ####'####: ##:::: ##:                                                           
 ##:::: ##: ######::: ## ### ##: ##:::: ##:                                                           
 ##:::: ##: ##...:::: ##. #: ##: ##:::: ##:                                                           
 ##:::: ##: ##::::::: ##:.:: ##: ##:::: ##:                                                           
 ########:: ########: ##:::: ##:. #######::                                                           
........:::........::..:::::..:::.......:::                                                           
'########::'##::::'##:'########::'##:::::::'####::'######:::::'###::::'########::'#######::'########::
 ##.... ##: ##:::: ##: ##.... ##: ##:::::::. ##::'##... ##:::'## ##:::... ##..::'##.... ##: ##.... ##:
 ##:::: ##: ##:::: ##: ##:::: ##: ##:::::::: ##:: ##:::..:::'##:. ##::::: ##:::: ##:::: ##: ##:::: ##:
 ##:::: ##: ##:::: ##: ########:: ##:::::::: ##:: ##:::::::'##:::. ##:::: ##:::: ##:::: ##: ########::
 ##:::: ##: ##:::: ##: ##.....::: ##:::::::: ##:: ##::::::: #########:::: ##:::: ##:::: ##: ##.. ##:::
 ##:::: ##: ##:::: ##: ##:::::::: ##:::::::: ##:: ##::: ##: ##.... ##:::: ##:::: ##:::: ##: ##::. ##::
 ########::. #######:: ##:::::::: ########:'####:. ######:: ##:::: ##:::: ##::::. #######:: ##:::. ##:
........::::.......:::..:::::::::........::....:::......:::..:::::..:::::..::::::.......:::..:::::..::
"@
    Write-Host $banner -ForegroundColor Cyan
}

function Show-Menu {
    Clear-Host
    Show-Banner
    Write-Host "`nDEMO DUPLICATOR - File Guardian and Duplicator`n"
    Write-Host "1. Set up new file monitoring"
    Write-Host "2. Run in background mode (Advanced)"
    Write-Host "3. Exit"
}

function Start-FileMonitoring {
    param(
        [string]$SourceFilePath,
        [string]$DestinationFilePath
    )



    while ($true) {
        if (-Not (Test-Path -Path $DestinationFilePath)) {
            Write-Host "File is missing in destination. Copying from source folder..." -ForegroundColor Yellow
            Copy-Item -Path $SourceFilePath -Destination $DestinationFilePath -Force
        }
        else {
            Write-Host "File is present in folder A." -ForegroundColor Green
        }

        Start-Sleep -Seconds 5
    }
}

function Start-BackgroundMonitoring {
    param(
        [string]$SourceFilePath,
        [string]$DestinationFilePath
    )



    # Create a background job for monitoring
    $job = Start-Job -ScriptBlock {
        param($SourceFilePath, $DestinationFilePath)
        
        while ($true) {
            if (-Not (Test-Path -Path $DestinationFilePath)) {
                Write-Host "File is missing in destination. Copying from source folder..." -ForegroundColor Yellow
                Copy-Item -Path $SourceFilePath -Destination $DestinationFilePath -Force
            }
            else {
                Write-Host "File is present in folder A." -ForegroundColor Green
            }
    

            Start-Sleep -Seconds 5
        }
    } -ArgumentList $SourceFilePath, $DestinationFilePath

    Write-Host "Background monitoring started. Job ID: $($job.Id)" -ForegroundColor Green
    Write-Host "To stop monitoring, use: Stop-Job -Id $($job.Id)" -ForegroundColor Yellow
    Write-Host "To view job details, use: Receive-Job -Id $($job.Id)" -ForegroundColor Yellow
}

function Main {
    do {
        Show-Menu
        $choice = Read-Host "Enter your choice (1-3)"

        switch ($choice) {
            '1' {
                $sourceFilePath = Read-Host "Enter full path to source file (e.g., C:\Path\To\B\FileA.txt)"
                $destinationFilePath = Read-Host "Enter full destination file path.i-e where file will be copied(e.g., C:\Path\To\B\FileA.txt)"

                # Validate inputs
                if (-not (Test-Path $sourceFilePath)) {
                    Write-Host "Error: Source file not found!" -ForegroundColor Red
                    pause
                    continue
                }


                Start-FileMonitoring -SourceFilePath $sourceFilePath -DestinationFilePath $destinationFilePath
            }
            '2' {
                $sourceFilePath = Read-Host "Enter full path to source file (e.g., C:\Path\To\B\FileA.txt)"
                $destinationFilePath = Read-Host "Enter full destination file path.i-e where file will be copied(e.g., C:\Path\To\B\FileA.txt)"

                # Validate inputs
                if (-not (Test-Path $sourceFilePath)) {
                    Write-Host "Error: Source file not found!" -ForegroundColor Red
                    pause
                    continue
                }



                Start-BackgroundMonitoring -SourceFilePath $sourceFilePath -DestinationFilePath $destinationFilePath
                Write-Host "Background process started, you can close the terminal" -ForegroundColor Green
            }
            '3' {
                Write-Host "Exiting Demo Duplicator..." -ForegroundColor Yellow
                exit
            }
            default {
                Write-Host "Invalid choice. Please try again." -ForegroundColor Red
            }
        }
    } while ($true)
}

# Run the main function
Main
