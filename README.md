# JMeter Distributed Testing POC
This project demonstrates a modernized approach to performance testing by migrating from static on-premise VMs to a dynamic, containerized infrastructure.

### Key Features:
* **Scalable Architecture**: One JMeter Master with dynamically scalable Load Generator Slaves (0 to N).
* **Zero-Configuration Monitoring**: Automated data pipeline from JMeter to InfluxDB.
* **Visual Observability**: Pre-configured Grafana dashboards for real-time analysis.
* **Portability**: Define your entire testing lab as code using Docker Compose.

## Quick Start

### Default Setup (2 slaves):
```bash
docker-compose up -d
```

### Scale Slaves On-Demand:

**Increase to 5 slaves:**
```bash
docker-compose up -d --scale jmeter-slave=5
```

**Reduce to 1 slave:**
```bash
docker-compose up -d --scale jmeter-slave=1
```

**Stop all slaves (conserve resources):**
```bash
docker-compose up -d --scale jmeter-slave=0
```

### Running a Test:
Find the slave container names and execute:
```bash
docker-compose exec jmeter-master jmeter -n -t /scripts/sample_test.jmx -R jmeter-slave_1,jmeter-slave_2
```

### Monitoring:
Access Grafana at `http://localhost:3000` (Default: admin/admin)
