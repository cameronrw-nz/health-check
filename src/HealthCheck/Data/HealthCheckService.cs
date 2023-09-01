namespace HealthCheck.Data;
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
            var str = File.ReadAllText("data.json");

            var result = !string.IsNullOrEmpty(str)
                ? JsonConvert.DeserializeObject<HealthCheckResult>(str)
                : new HealthCheckResult();

            result.Date = DateTime.Now;

            _healthCheck = result;
        };
        t.Interval = 1000;
        t.Start();
    }
}
