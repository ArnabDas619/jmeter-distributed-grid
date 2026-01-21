# Data Persistence Guide

## Overview
Your JMeter distributed testing setup is **already configured** to persist data across container restarts. This means your historical test results will NOT be lost when you stop and restart containers.

## What's Persisted

### ✅ InfluxDB Data (Test Results)
- **Location**: `./data/influxdb/`
- **Mounted to**: `/var/lib/influxdb` inside the container
- **Contains**: All JMeter test metrics, time-series data, and historical test runs
- **Persistence**: Data survives container restarts, stops, and rebuilds

### ✅ Grafana Data (Dashboards & Settings)
- **Location**: `./data/grafana/`
- **Mounted to**: `/var/lib/grafana` inside the container
- **Contains**: Custom dashboards, user preferences, datasource configurations
- **Persistence**: All dashboard changes and settings are saved

## How It Works

The docker-compose.yml file includes volume mappings:

```yaml
influxdb:
  volumes:
    - ./data/influxdb:/var/lib/influxdb  # ← Data persists here

grafana:
  volumes:
    - ./data/grafana:/var/lib/grafana    # ← Data persists here
```

When you run tests:
1. JMeter sends metrics to InfluxDB
2. InfluxDB writes data to `/var/lib/influxdb` (inside container)
3. Docker maps this to `./data/influxdb/` (on your host machine)
4. Data remains on your host even when container is stopped/removed

## Testing Data Persistence

### Verify Data is Persisting:

1. **Run a test:**
   ```bash
   docker-compose exec jmeter-master jmeter -n -t /scripts/Testing_1.jmx -R jmeter-slave_1,jmeter-slave_2
   ```

2. **Check data exists:**
   ```bash
   dir data\influxdb
   ```
   You should see InfluxDB files (meta, data, wal directories)

3. **Stop containers:**
   ```bash
   docker-compose down
   ```

4. **Restart containers:**
   ```bash
   docker-compose up -d
   ```

5. **Access Grafana** (http://localhost:3000) - Your old test data should still be visible!

## Data Management

### View Historical Data
In Grafana, use the time range picker to view past test runs. All data is retained indefinitely unless you manually delete it.

### Clear Old Data (Optional)
If you want to start fresh:

```bash
# Stop containers first
docker-compose down

# Delete InfluxDB data
rmdir /s /q data\influxdb

# Recreate directory
mkdir data\influxdb

# Restart
docker-compose up -d
```

⚠️ **Warning**: This permanently deletes ALL historical test data!

### Backup Your Data

**Backup InfluxDB:**
```bash
# While containers are running
docker-compose exec influxdb influxd backup -portable /var/lib/influxdb/backup
```

**Backup directories:**
```bash
# Simple backup of entire data folder
xcopy /E /I data data_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%
```

**Restore from backup:**
```bash
# Stop containers
docker-compose down

# Restore data folder
xcopy /E /I data_backup_YYYYMMDD\influxdb data\influxdb
xcopy /E /I data_backup_YYYYMMDD\grafana data\grafana

# Restart
docker-compose up -d
```

## Troubleshooting

### Data not persisting?

1. **Check volume mapping:**
   ```bash
   docker-compose config | findstr volumes -A 2
   ```

2. **Verify directory permissions:**
   ```bash
   dir data
   ```

3. **Check InfluxDB logs:**
   ```bash
   docker-compose logs influxdb
   ```

4. **Inspect mounted volumes:**
   ```bash
   docker inspect influxdb | findstr /C:"Mounts" -A 20
   ```

### Data directory is empty after restart?

- Ensure you're using `docker-compose down` NOT `docker-compose down -v` (the `-v` flag removes volumes!)
- Check that the `./data/influxdb` path is correct relative to docker-compose.yml

## Best Practices

1. **Regular Backups**: Backup your data folder periodically
2. **Version Control**: Commit `.gitkeep` files but NOT the actual data (already in .gitignore)
3. **Storage Monitoring**: Monitor disk space as test data accumulates over time
4. **Data Retention**: Consider implementing a data retention policy for old tests

## Storage Location

Your test data is stored on your host machine at:
```
c:\Users\Arnab Das\Desktop\Performace_testing\jmeter-distributed-grid\data\
├── influxdb\     ← All test metrics (time-series data)
└── grafana\      ← Dashboard configurations and settings
```

This data is **independent of Docker containers** and will persist as long as these directories exist on your file system.
