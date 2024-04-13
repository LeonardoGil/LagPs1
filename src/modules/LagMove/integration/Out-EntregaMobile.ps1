function Out-EntregaMobile() {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline=$true)]
        [guid]
        $viagemId, 

        [Parameter(Mandatory)]
        [guid[]]
        $entregasId,

        [switch]
        $foraDoRaio,

        [switch]
        $fotoValida
    )

    $entregas = @()
    
    $random = [System.Random]::new()
    $date = [system.DateTime]::Now.ToString('yyyy-MM-ddTHH:mm:ss')

    foreach ($entregaId in $entregasId) {
        $latitude = ($random.NextDouble() * 100) - 50
        $longitude = ($random.NextDouble() * 100) - 50
        $ticks = [System.DateTime]::Now.Ticks

        $entrega = @{
            created_at = $ticks
            update_at = $ticks
            entregaForaDoRaio = $foraDoRaio.IsPresent
            nomeRecebedor = "Leonardo"
            documentoRecebedor = (Get-CPFAleatorio)
            latitude = $latitude.ToString('F6')
            longitude = $longitude.ToString('F6')
            fotoCanhoto = "/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsKCwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAARCAAeAI8DASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9QItc0+abyor+1kl/55pMpbj2pmk+JdK15pF07UrO/aL/AFn2adZNv12mvxv+Hfwv1f4u/tE6p4T0HVv7Cu9Rub9Li++b5bYMzS9Mbs/3a1tQ8I+Iv2Pf2mtI02x1fz7yzubWVby2jaNbq2mZd0bp7j5Stew8vjflU/ete39M+XWczaVSVL3L8t79T9hby+g023ee6njtoE+9LM+1V/E185ftmfG7Vfh78DU8UfD/AMQWsd7/AGtbWv2y18q6Ty23bl53LXyN+1V4u8U/tKftSn4X6bdGHTLLUP7JsbJ3K2/nIu6e5lA+9j5/+ApWL+01+xzrn7Nfgi21Oy8Uf274dv7mO3v4Eg+zbZ/mMTFN5DL9/wD3aKOEhGUHUnq+gYvMak4VY0YO0bpyvsz7u/Ys+JXiP4sfAnTvEXiq9/tDV5bu6iafy1j+VJGC/KqgV7AvirSbq8n0+21Wxl1KNWzapMrSrj/Yzmvy+uvjNrPw3/Yb8E6Bod7Jpl34k1bU0nvIZNsiW0Un7xVP8O8ula3wz/4J9+KfEXwqsviDp3ipdI8Tzwf2ppmnwxtu2/fj3XAYMrn/AHaVTCQ5pTnLlV2kOjmVXkhSpQ55KKb1PSf2If2nfiP8XvjRqeh+MPEEeo6XFpM10sf2SGH51kjUNuRR/C1dX8Y/2rtZ1TV59H8Fz/YtPjfyv7RRN8103+x/dX0/ir5U/YrvLix8YfEK4t/+PtfBt/8A727zIc19K/sZ6FpuqfEi9uL1I3uLCy82zV/7xbDN+C18/nspxxcMLRfLzLVo/UfD/D4d5Tis6zCHtfYvSL2b7v8AC3zOVm8ffFzwf5Oq32o+ItPik+7JqCN5cv8A32uK9l/Z1+O3ij4lfFKSy1q6j+wtpjbbWFNse9WX5/XJ3V7h8SvhDoPxWtrKLW/tWLNmeI2s3l9etcL8Ifgp4D8LeKn8ReF/EE+ry2ySW7RG7jmVc8NnaBXjU8HicPXjyTvDzf6H1uJz7J8zyyq62GUK/K0nGOiu9NT2TUvEWl6OwW/1G0smb/nvMsf86tx3UU9uJYnR4v8Anov3a/JL4gfB/wCE58deJP7Y+PVq9y99N9nEOj3Wp7I/MbYs9xu27h907a2f2I/iLq/hf4ma94Ci1j+0/DWp6ZqG2KN2a382KJnE8QP3dyrX20sD+7c4yvbysfgsc3/eqlUha+is0/yP1Ij8Q6bNHI8WoWsiRrvkZZlO1f7xqS31iwu9NF/BfQTWBTf9qjkVo9v+90r8RfgX8N/Fvxb1w+DvCMvkNqlurahvfy4fIj53TY/hDfw16n8eY/GWh6t4K/Z3TU457XQktrJo7V2jt769upN6u/favnKvzf7daSy9Rnyc+v6GUM6lKnKrKlotFru+x+r9j4q0XVLWWe01exureP8A1ksFyjKn1YHirlnqFrfR77W6juk/vQurfyr8wvjh+wfrHwC+EWqeKtN8anVEiiji1mxSD7NHLC0ijj5zvUNt+Vqp/An41ah8Df2OfGup6GBDruqeJ10yxn/592e0V2lx7Ir4/wBqsvqalDnpT5tbG/8Aak6VT2WIp8ul97/ofp5qPizRdFmSDUNXsbGdvux3NzHGzfQE1ro6uPl+Za/K/wCCv7DPiP8AaN8Cv8Qda8YnT7jVHke0N5A17NcYbHmSuXGMla0/2RPjZ4l/Z7+NGq/C3xjevJoUUtxayWksm9LO5iVmDwsekbqvT/cpywUVzKnO8o7odPNJ80XXpcsZbO/5mZ+xfE8f7b0m5H/5i/VP96j9vRZD+2FZOiOf9H0z+D/ppX6neTFuzs+ahrWOT70an8Kn66/a+15elg/sr/Z/Yc/2ua9vw3Py6/ay+H/i/wDZ5/aYPxT0K2kn0u6vv7Vtr/yPMhhnb/WwTY+7u+f/AIC9c1+0R+1h4x/aU8Cw2y+EjofhjTryOW+uLZ3uFkuSrCJS5Ubf48LX6zPDFPFtdPMjfqrUy30u2s7f7PBbQxQ/880QKv5CrjjorldSF3HqKrlUpc8adVxjPVqx+XEfwN1z4qfsO+DdZ8OWL6jqXhzVtTkksY0/ey20snz7F/iYNGjbaf8ADL9ur4haH8OLH4Z6N4VXVvEsUH9l6bfx+Z9oVcbV3W+35nT/AHq/UyONV+4NtVY9NsxcNdpawrcP1lEY3n8aX11SuqkObW612uP+y502nRq8rsk9N7H5df8ABN/Svt3x216yvYXa3uPD11FN5n8eZIQ1ei+NPAXiv9nbxx/aGnvPBaxO39n6snzRtH/dftux1Vq/QgW8afdjUfhTLi1juofJmjWWN/vJINwrx80prMpqr8Mls/6sfccKZnV4XhOjyqrTn8UXpf8AP9T4L8SftZeOfE2ivpfnWOneenlST2SMszf7uWO3/gNbHwy/Z38V3Xw58Za7Ek+l6xeaHd2WjWr/ALuRpJI8bm/u/wB0f99V9h2XgXw5pVz59poWnWtx/wA9obVFb88Vu15lDATp1o1q1Rycdj6bMeJ8PWwNTLsrwyoQqaSe7a7bf5n43/APx94M+DepeINM+IXwrk8Ya1IVitLW6j/eWrDcrQ+VIvdv4q2P2W/Mf9qi6l/sT/hH91vrL/2TGjKtlm0n/dc/3Pu1+t8mmWbXX2t7WFrpOk3ljf8AnVj7NH18td3rivrpZgpKa5NZLufjcMmceRe00i77L8z8zf8AgldE3/C0PFe9Nn/Ehj++n/TZa9B/bo/ZZ8Q+MPiHp/jzwM8c+uXUSpPpK3Sw3TvAPlnt8kb2VdmVX5q+8Vt41+4u36V8xftW/sh3v7ReuaVrVh4wk0K+0iBoobOa38y35bLSBlIZXPHNTHFe0xHtfhv8/wDI0qZeqWBeHS52nft/mfIPxo179o7xd8I71viYH0LwnprwiQ6hBHZS6lNuxHHtHzytxu6ba1fgT8BtV+OX7GXjGx0pP+JxZ+J/7S01ZPl+0SR2saPFu91f/vqu0h/4Jo+Ptfv4R4o+KEN1ZwnG7FxdyIP9gSsFWvuH4R/CvRPg34E07wp4fjZNPsx/rJjukmkb5nkc/wB4mt62KjSpKNO3Ne+iscGGwFTEVnUrp8tratN/gfm38H/21/Gv7M/hF/AGseD1vH05pBaRak8lpNbMWyY3Xady7mrqf2QfgP4q+OXxk1H4q+OdPe00WZ7i63zweT9vuZlZcxKf4EVvvV+kF9pOn30sRu7KC6cfcaaMPt/OtDZXNLGr3nThyyluz0qeVSUoe3qOUY7Kx//Z"
            observacoes = "Scriptzao do LEO"
            documentoId = $entregaId
            viagemId = $viagemId
            dataHora = $date
            fotoValida = $fotoValida.IsPresent
        }    

        $entregas += $entrega
    }


    $object = [PSCustomObject]@{ 
        entregas = $entregas
    }

    $json = $object | ConvertTo-Json -Depth 15

    Set-Clipboard -Value $json

    return $json
}