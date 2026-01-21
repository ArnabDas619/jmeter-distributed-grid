# JMeter Performance Testing - Quick Start

## 🚀 Getting Started

### 1. Start the Environment
```bash
docker-compose up -d
```

This will start:
- 1 JMeter Master
- 2 JMeter Slaves (scalable with `--scale jmeter-slave=N`)
- InfluxDB for metrics storage
- Grafana with pre-configured dashboard

### 2. Run Your Performance Test
```bash
docker-compose exec jmeter-master jmeter -n -t /scripts/Testing_1.jmx -R jmeter-slave_1,jmeter-slave_2
```

### 3. View Results in Grafana
1. Open http://localhost:3000 in your browser
2. Login with `admin` / `admin`
3. Navigate to **Dashboards** → **Browse** → **JMeter** folder
4. Open **JMeter Performance Dashboard**

**That's it!** Your dashboard is pre-configured and will automatically display:
- ✅ Response time percentiles (90th, 95th, 99th)
- ✅ Throughput (requests/sec)
- ✅ Error rates
- ✅ Active threads
- ✅ Transaction-level metrics

## 📊 Dashboard Panels

| Panel | Description |
|-------|-------------|
| **Response Time Percentiles** | Shows average, 90th, 95th, and 99th percentile response times |
| **Throughput** | Requests processed per second |
| **Error Rate %** | Percentage of failed requests (gauge) |
| **Active Threads** | Current number of virtual users |
| **Total Requests** | Total successful requests count |
| **Total Errors** | Total failed requests count |
| **Response Time by Transaction** | Individual transaction performance breakdown |
| **Requests Over Time** | Success vs Error comparison |

## 🔧 Scaling JMeter Slaves

### Increase to 5 slaves:
```bash
docker-compose up -d --scale jmeter-slave=5
```

### Reduce to 1 slave:
```bash
docker-compose up -d --scale jmeter-slave=1
```

### Stop all slaves (conserve resources):
```bash
docker-compose up -d --scale jmeter-slave=0
```

## 📝 Creating Your Own Tests

Edit or create new `.jmx` files in the `scripts/` folder. Make sure to include the InfluxDB Backend Listener with:
- **URL**: `http://influxdb:8086/write?db=jmeter`
- **Application**: Your application name
- **Test Title**: Unique test identifier
- **Tags**: Custom tags for filtering (e.g., `environment=prod,test_type=spike`)

## 🛠️ Troubleshooting

**Dashboard shows no data?**
- Run a test first using the command in step 2
- Check that InfluxDB is running: `docker-compose ps influxdb`
- Verify test is sending data: `docker-compose logs -f jmeter-master`

**Cannot access Grafana?**
- Ensure port 3000 is not in use: `netstat -an | findstr :3000`
- Check Grafana logs: `docker-compose logs grafana`

**Slaves not responding?**
- Check slave status: `docker-compose ps`
- View slave logs: `docker-compose logs jmeter-slave_1`
