$base = Read-Host -Prompt "Ingrese la ruta al archivo o respaldo de la base"
$tipo = Read-Host -Prompt "Ingrese 1 si el archivo es MDF o 2 si el archivo es BAK"
if($tipo -eq 1 -or $tipo -eq 2){
    if($tipo -eq 1){
        $resultado = get-content -Encoding Byte $base | select-object -skip 0x12064 -first 2
    }else{
        $resultado = get-content -Encoding Byte $base | select-object -skip 0x0EAC -first 2
    }
    
    $version = ($resultado[1]*256)+$resultado[0]

    if($version -ge 539 -and $version -lt 611){
        Write-Host "La base es versión SQL 2000 Version:"$version -ForegroundColor Green
    }else{
        if($version -ge 611 -and $version -lt 655){
            Write-Host "La base es versión SQL 2005 Version:"$version -ForegroundColor Green
        }else{
            if($version -ge 655 -and $version -lt 782){
                Write-Host "La base es versión SQL 2012 Version:"$version -ForegroundColor Green
            }else{
                if($version -eq 782){
                    Write-Host "La base es versión SQL 2014 Version:"$version -ForegroundColor Green
                }else{
                    Write-Host "La base tiene una versión desconocida Version:"$version -ForegroundColor Red
                }
            }
        }
    }
}else{
    Write-Host "Error opción inválida" -ForegroundColor Red
}
Read-Host -Prompt "Presione una tecla para salir"
Write-Host "Jaime Moscoso @ 2016"
