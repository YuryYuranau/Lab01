cls
# cd d:\Epam\Lab01\
$GC = Get-Content .\My.config            # Здесь осторожно - если нет файла, то застопит все что запущено и запустит всё что застоплено ;)
$St = Get-Service -ServiceName $GC       # Загоняем в переменную сервис заранее подобранный из файла 
$SSt = $St.Status                        # Загоняем в переменную статус сервиса
$SNa = $St.Name                          # Загоняем в переменную имя сервиса
$SNf = "Error. Service not found."       # Надоело копипастить длинные куски текста...
$dt = Get-Date -Format "yyyyMMdd_HHmmss" # Загоняем в переменную дату и время
$lfndt = "Lab1_" + $dt + ".Log"          # Загоняем в переменную имя будущего лог-файла
"Поехали!" | Out-File "$lfndt"
If ($SSt -eq "Running") 
    { 
    Write-Host "Service status was Running" 
    } 
    ELSEIF ($SSt -eq "Stopped") { 
    Write-Host "Service status was Stopped" 
    }
    ELSE { Write-Host "$SNf" 
    }

If ($SSt -eq "Running") { 
 Write-Host "Service is Stopping now..." 
 stop-service $SNa -PassThru | Out-File "$lfndt" -Append # создаём объект представляющий старт службы и загоняем результат в файл
 # "$SNa" + " - " + "$SSt" | Out-File "$lfndt" -Append
     }
    ELSEIF ($SSt -eq "Stopped") { 
 Write-Host "Service is Starting now..."
 start-service $SNa -PassThru | Out-File "$lfndt" -Append # создаём объект представляющий стоп службы и загоняем результат в файл
 # "$SNa" + " - " + "$SSt" | Out-File "$lfndt" -Append
     }
    ELSE { 
 $SNf | Out-File "$lfndt" -Append
 Write-Host "Service was not found" 
     }
# Wait-Process $SNa
# "$SNa" + " - " + "$SSt" | Out-File "$lfndt"
