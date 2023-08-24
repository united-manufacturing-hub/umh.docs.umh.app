try
{
    Set-Location -Path ".\umh.docs.umh.app"
    hugo serve -D
}
finally
{
    Set-Location -Path "..\"
}
