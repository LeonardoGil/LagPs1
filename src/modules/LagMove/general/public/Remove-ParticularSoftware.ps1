using namespace System.IO;

function Remove-ParticularSoftware {

    $particularSoftwarePath = [Path]::Combine($env:LOCALAPPDATA, 'ParticularSoftware');
    Write-Output $particularSoftwarePath

    if (Test-Path -Path $particularSoftwarePath) {
        Write-Output "Excluindo pasta";
        Remove-Item -Path $particularSoftwarePath -Force;
    }
    else {
        Write-Output 'ParticularSoftware não encontrado!';
        return;
    }
}
