param([String] $path, [String] $filterType,[String[]] $filter)

$ErrorActionPreference = "Stop"

if([string]::IsNullOrEmpty($path)){
    $path = pwd
}else{
    $checkPath = Test-Path -Path $path
    $checkPath
    if(!$checkPath){
        $path = pwd;
    }
}

if(($filterType -eq $null)-or($filterType -ne "E")-and($filterType -ne "I")){
   $filter = $null
}

try {
    $datas = ls -r $path
}catch [System.UnauthorizedAccessException] {
     "Permessi insufficenti per eseguire l'analisi su tutti i file"
     Exit
}

$folder = 0;
$files = 0;
$extension = @();


$filter = $filter | Get-Unique

$filter

foreach($data in $datas){
    if($data.PsIsContainer){
        $folder++
    }else{
        $temp = ($data.Extension).ToLower()
        if($temp -eq ""){
            $temp = "noext"
        }
        if($filter -ne $null){
            if($filterType -eq "E"){
                if(!$filter.Contains("$temp")){
                    if(($extension.Name -eq $null)-or(!($extension.Name.Contains("$temp")))){
                        $extension += [pscustomobject]@{Name="$temp";Qty=0;"Qty_%"= 0;Size_KB = 0}
                    }
                    $index = ($extension.Name).IndexOf("$temp")
                    $extension[$index].Size_KB += [Math]::Round(($data.Length / 1KB),2)
                    $extension[$index].Qty++
                    $files++
                }
            }elseif($filterType -eq "I"){
                if($filter.Contains("$temp")){
                    if(($extension.Name -eq $null)-or(!($extension.Name.Contains("$temp")))){
                        $extension += [pscustomobject]@{Name="$temp";Qty=0;"Qty_%"= 0;Size_KB = 0}
                    }
                    $index = ($extension.Name).IndexOf("$temp")
                    $extension[$index].Size_KB += [Math]::Round(($data.Length / 1KB),2)
                    $extension[$index].Qty++
                    $files++
                }
            }else{
                if(($extension.Name -eq $null)-or(!($extension.Name.Contains("$temp")))){
                    $extension += [pscustomobject]@{Name="$temp";Qty=0;"Qty_%"= 0;Size_KB = 0}
                }
                $index = ($extension.Name).IndexOf("$temp")
                $extension[$index].Size_KB += [Math]::Round(($data.Length / 1KB),2)
                $extension[$index].Qty++
                $files++
            }
        }else{
            if(($extension.Name -eq $null)-or(!($extension.Name.Contains("$temp")))){
                $extension += [pscustomobject]@{Name="$temp";Qty=0;"Qty_%"= 0;Size_KB = 0}
            }
            $index = ($extension.Name).IndexOf("$temp")
            $extension[$index].Size_KB += [Math]::Round(($data.Length / 1KB),2)
            $extension[$index].Qty++
            $files++
        }
    }
}

for($i = 0;$i -lt $extension.Name.Count;$i++){
    $extension[$i]."Qty_%" = [Math]::Round(($extension[$i].Qty/$files)*100,2)
}


write-host "Folders: "$folder
write-host "Files: "$files`n


$extension
