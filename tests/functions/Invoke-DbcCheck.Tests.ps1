﻿$commandname = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", "")
Write-Host -Object "Running $PSCommandpath" -ForegroundColor Cyan
. "$PSScriptRoot\..\constants.ps1"

Describe "$commandname Integration Tests" -Tags IntegrationTests, Integration {
    @(Get-DbcConfigValue testing.integration.instance).ForEach{
        Context "Command executes properly and returns proper info on $psitem" {
            It "runs a check" {
                $results = Invoke-DbcCheck -ComputerName $psitem -Tag DiskCapacity -Passthru -Show None
                $results.TestResult | Should Not Be $null # Because nothing else works right now
            }
        }
    }
}