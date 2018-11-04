mkdir dist;
start-job -name RemoveItem -ScriptBlock{
    Remove-Item check.ps1
}
