namespace HealthCheck.Data;

using System.Diagnostics;
using Newtonsoft.Json;

public class HealthCheckService
{

    HealthCheckResult _healthCheck = new HealthCheckResult() { Date = DateTime.Now };
    public HealthCheckResult HealthCheck
    {
        get
        {
            return _healthCheck;
        }
    }

    public HealthCheckService()
    {
        System.Timers.Timer t = new System.Timers.Timer();
        t.Elapsed += async (s, e) =>
        {
            try
            {
                var str = File.ReadAllText("data.json");

                var result = !string.IsNullOrEmpty(str)
                    ? JsonConvert.DeserializeObject<HealthCheckResult>(str)
                    : new HealthCheckResult();

                result.Date = DateTime.Now;

                _healthCheck = result;
            }
            catch (Exception)
            {

            }
        };
        t.Interval = 1000;
        t.Start();
    }

    public void TriggerHealthCheck()
    {
        var ps1File = @"C:\code\other\check.ps1";

        var startInfo = new ProcessStartInfo()
        {
            FileName = "powershell.exe",
            Arguments = $"-NoProfile -ExecutionPolicy ByPass -File \"{ps1File}\"",
            UseShellExecute = false
        };
        Process.Start(startInfo);
    }
}
