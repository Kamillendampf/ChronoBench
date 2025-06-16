# 🔪 CronoBench

**CronoBench** is a PowerShell-based automation and benchmarking framework designed to measure response times of configurable HTTP endpoints. It is ideal for evaluating application warm-up performance, process initialization overhead, and the impact of different service configurations on response latency.

---

## 🚀 Features

* ⚙️ **Custom Application Launch**
  Start any application via a configurable `.bat` file and simulate realistic start-up conditions.

* 📡 **Endpoint Testing with Dynamic Payload**
  Send structured JSON payloads via HTTP POST to configurable endpoints.

* ⏱️ **High-Precision Response Time Measurement**
  Capture response latency in milliseconds using a high-resolution stopwatch.

* 🧼 **Process Isolation & Cleanup**
  Detect and terminate any spawned processes after each test iteration to ensure consistency.

* 🧾 **Persistent Logging**
  Log all response times to a file for later analysis or visualization.

---

## 🔧 Configuration

Before running CronoBench, the following key variables must be configured within the script:

### `batFile`

Path to the `.bat` file that starts the application under test.

```powershell
$batFile = "C:\path\to\your\start-script.bat"
```

### `url`

Target URL of the web service endpoint to be tested.

```powershell
$url = "http://your-api-endpoint.com/path"
```

### `payload`

JSON-formatted string representing the request body to be sent with each POST request.

```powershell
$payload = @'
{
  "example": "data"
}
'@
```

### `username` / `password`

Basic Authentication credentials for the endpoint.

```powershell
$username = "your-username"
$password = "your-password"
```

### `outputFile`

Path to the file where the script will log response times.

```powershell
$outputFile = ".\response-times.txt"
```

---

## 🔀 Execution Logic

1. **Initial Process Snapshot:**
   Capture the list of currently running processes to later identify new ones.

2. **Benchmark Loop (e.g., 85 iterations):**

   * Start the application via the `.bat` file.
   * Wait for a fixed warm-up period (e.g., 30 seconds).
   * Send a POST request to the configured endpoint with the custom payload.
   * Measure and record the elapsed response time.
   * Terminate all new processes started during this iteration.

3. **Logging:**
   All response times are appended to the output file in plain text format.

---

## 📂 Output Example

A typical `response-times.txt` log might look like this:

```
with Preloading
450 ms
433 ms
472 ms
...
```

---

## 📋 Prerequisites

* Windows with PowerShell (v5 or later)
* Valid `.bat` file for application startup
* Network access to the target HTTP endpoint
* Properly structured JSON payload

---

## 🛝 Use Cases

* Benchmark application cold/warm start performance
* Evaluate the impact of system preloading
* Automate HTTP performance testing in local or CI environments
* Compare response behavior across builds or configurations

---

## 📜 License

This project is released under the MIT License. Feel free to use, adapt, and extend it as needed.

---

## ✍️ Author

**CronoBench** is designed for engineers and testers who require precision and control in response-time benchmarking. Built with simplicity, flexibility, and repeatability in mind.
