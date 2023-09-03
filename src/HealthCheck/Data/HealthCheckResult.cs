namespace HealthCheck.Data;

public class HealthCheckResult
{
    public DateTime Date { get; set; }

    public ResultSet[] ResultSets { get; set; } = new ResultSet[0];
}

public class ResultSet
{
    public string Name { get; set; }

    public Result[] Results { get; set; } = new Result[0];
}

public class Result
{
    public string Name { get; set; }

    public string? DisplayText { get; set; }

    public Status Status { get; set; }

    public string[]? HelpText { get; set; }
}

public enum Status
{
    Processing,
    Success,
    Warning,
    Failure
}