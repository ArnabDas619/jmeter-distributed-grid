# Grafana Visualization Guide for JMeter Tests

## Overview
InfluxDB is now automatically configured as a data source in Grafana, and a **pre-built JMeter Performance Dashboard** is automatically loaded when Grafana starts.

## ✅ What's Already Configured

### Auto-Provisioned Data Source
- **Name**: InfluxDB-JMeter
- **Type**: InfluxDB
- **URL**: http://influxdb:8086
- **Database**: jmeter
- **Status**: Set as default data source

### Auto-Provisioned Dashboard
**JMeter Performance Dashboard** includes 8 panels:
1. **Response Time Percentiles** - 90th, 95th, 99th percentiles and average
2. **Throughput** - Requests per second
3. **Error Rate %** - Percentage of failed requests
4. **Active Threads** - Current number of active virtual users
5. **Total Requests (Success)** - Count of successful requests
6. **Total Errors** - Count of failed requests
7. **Response Time by Transaction** - Individual transaction performance
8. **Requests Over Time** - Success vs Error comparison

## How to Access Grafana

1. **Start your environment:**
   ```bash
   docker-compose up -d
   ```

2. **Access Grafana:**
   - URL: http://localhost:3000
   - Username: `admin`
   - Password: `admin`

3. **Access the Dashboard:**
   - Go to **Dashboards** → **Browse**
   - Look for **JMeter** folder
   - Click on **JMeter Performance Dashboard**
   - The dashboard is pre-configured and ready to display your test data!

4. **Verify Data Source (Optional):**
   - Go to **Configuration** (gear icon) → **Data Sources**
   - You should see `InfluxDB-JMeter` already configured ✅

## Creating Your First Dashboard

### Step 1: Create a New Dashboard
1. Click the **+** icon → **Dashboard**
2. Click **Add new panel**

### Step 2: Configure Panel for Response Time
**Query Configuration:**
- **FROM**: `jmeter`
- **WHERE**: 
  - `application = Manchester_University_Test`
  - `testTitle = Testing_1`
  - `statut = ok` (for successful requests)
- **SELECT**: 
  - **field(pct95.0)** → **mean()**
- **GROUP BY**: `time($__interval)` fill(null)

**Panel Settings:**
- **Title**: "95th Percentile Response Time"
- **Visualization**: Time series
- **Unit**: milliseconds (ms)

### Step 3: Add Throughput Panel
**Query Configuration:**
- **FROM**: `jmeter`
- **WHERE**: 
  - `application = Manchester_University_Test`
  - `testTitle = Testing_1`
- **SELECT**: 
  - **field(count)** → **derivative(1s)**
- **GROUP BY**: `time($__interval)`

**Panel Settings:**
- **Title**: "Requests per Second"
- **Visualization**: Time series
- **Unit**: requests/sec

### Step 4: Add Error Rate Panel
**Query Configuration:**
- **FROM**: `jmeter`
- **WHERE**: 
  - `application = Manchester_University_Test`
  - `statut = ko` (failed requests)
- **SELECT**: 
  - **field(count)** → **sum()**
- **GROUP BY**: `time($__interval)`

## Available Metrics in InfluxDB

JMeter sends these key metrics to InfluxDB:

| Metric | Description |
|--------|-------------|
| `pct90.0`, `pct95.0`, `pct99.0` | Response time percentiles |
| `count` | Number of requests |
| `countError` | Number of failed requests |
| `min`, `max`, `avg` | Response time statistics |
| `hit` | Number of hits per transaction |

## Available Tags for Filtering

Your test is tagged with:
- `application = Manchester_University_Test`
- `testTitle = Testing_1`
- `test_type = load_test`
- `environment = dev`
- `target = manchester_university`
- `transaction` = Request name (e.g., "Manchester University Homepage")
- `statut` = `ok` or `ko` (success/failure)

## Sample Dashboard Queries

### Query 1: Average Response Time by Transaction
```
SELECT mean("avg") 
FROM "jmeter" 
WHERE ("application" = 'Manchester_University_Test' 
  AND "testTitle" = 'Testing_1') 
  AND $timeFilter 
GROUP BY time($__interval), "transaction" fill(null)
```

### Query 2: Error Rate Percentage
```
SELECT (sum("countError") / sum("count")) * 100 
FROM "jmeter" 
WHERE ("application" = 'Manchester_University_Test') 
  AND $timeFilter 
GROUP BY time($__interval)
```

### Query 3: Concurrent Users
```
SELECT max("maxAT") 
FROM "jmeter" 
WHERE ("application" = 'Manchester_University_Test') 
  AND $timeFilter 
GROUP BY time($__interval)
```

## Running a Test and Viewing Results

1. **Start the containers:**
   ```bash
   docker-compose up -d
   ```

2. **Run your test:**
   ```bash
   docker-compose exec jmeter-master jmeter -n -t /scripts/Testing_1.jmx -R jmeter-slave_1,jmeter-slave_2
   ```

3. **View in Grafana:**
   - Data starts flowing to InfluxDB immediately
   - Refresh your Grafana dashboard to see real-time results
   - Use the time range selector to focus on your test window

## Tips for Better Visualizations

1. **Use Variables**: Create dashboard variables for `testTitle` to switch between test runs
2. **Add Annotations**: Mark specific events during your test
3. **Set Alert Rules**: Configure alerts for response time thresholds or error rates
4. **Use Multiple Axes**: Compare response times and throughput on the same graph
5. **Save and Share**: Export your dashboard JSON for team collaboration

## Troubleshooting

**No data showing in Grafana?**
- Verify InfluxDB is running: `docker-compose ps influxdb`
- Check JMeter backend listener configuration in your .jmx file
- Confirm test is running: `docker-compose logs -f jmeter-master`
- Test InfluxDB directly: `curl http://localhost:8086/query?db=jmeter&q=SHOW%20MEASUREMENTS`

**Data source connection failed?**
- Ensure all containers are on the same network (`jmeter-net`)
- Restart Grafana: `docker-compose restart grafana`
