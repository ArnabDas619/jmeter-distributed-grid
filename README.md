# JMeter Distributed Performance Testing Platform

> **A Modern, Containerized Solution for Enterprise Performance Testing**

---

## 📋 What Is This Project?

This is a **ready-to-use performance testing platform** that uses Docker containers instead of physical or virtual machines. Think of it as your complete testing lab in a box that can:

- **Scale instantly** from 1 to 50+ load generators with a single command
- **Monitor everything** in real-time through visual dashboards
- **Run anywhere** - your laptop, a server, or the cloud
- **Cost nothing** to keep idle - just stop the containers when not testing

### Perfect For
✅ Load testing web applications, APIs, and services  
✅ Capacity planning and performance benchmarking  
✅ Identifying bottlenecks before production deployment  
✅ Demonstrating infrastructure modernization initiatives  

---

## 💰 Business Value: Why Move from On-Premise VMs to Containers?

### The Old Way (On-Premise Hardware/VMs)

| Aspect | Traditional Approach | Annual Cost Impact |
|--------|---------------------|-------------------|
| **Hardware** | Dedicated servers for master + slaves (5-10 VMs) | $15,000 - $50,000 CAPEX |
| **Provisioning Time** | 2-4 weeks (procurement, setup, configuration) | Lost productivity |
| **Idle Resources** | VMs running 24/7 even when not testing | $3,000 - $8,000 wasted energy |
| **Scaling** | Manual VM cloning, IP configuration, firewall rules | 2-3 hours per change |
| **Maintenance** | OS patches, JMeter updates across all VMs | 4-8 hours monthly |
| **Team Onboarding** | Complex setup documentation, VM access management | Days per new team member |

**Total Annual Cost: ~$25,000 - $75,000** (CAPEX + OPEX)

---

### The New Way (This Containerized Solution)

| Aspect | Container Approach | Annual Cost Impact |
|--------|-------------------|-------------------|
| **Hardware** | Runs on any laptop/server with Docker | $0 additional |
| **Provisioning Time** | 2 minutes (`docker-compose up -d`) | Instant productivity |
| **Idle Resources** | Stop containers when not testing (0 cost) | $0 wasted |
| **Scaling** | `--scale jmeter-slave=20` (5 seconds) | Instant |
| **Maintenance** | Update one Dockerfile, rebuild (5 minutes) | 15 minutes monthly |
| **Team Onboarding** | Clone repo + run 1 command | Hours → Minutes |

**Total Annual Cost: ~$0 - $5,000** (just compute time when running)

### **Cost Reduction: 70-95%** 💵

---

## 🚀 The Strategic Roadmap: Your Cloud Migration Path

This project represents **Step 1** of a three-phase modernization journey:

### Phase 1: Containerization ✅ **(You Are Here!)**
- Replace static VMs with Docker containers
- Achieve instant scaling and portability
- Eliminate hardware dependencies
- **Savings: 70%** compared to on-prem

### Phase 2: Cloud Migration 🎯 **(Next Step)**
- Deploy to AWS ECS/Fargate, Azure AKS, or GCP GKE
- Pay only for test duration (per-second billing)
- Access unlimited compute capacity on-demand
- **Additional Savings: 50-80%** vs running your own servers

**Example:** Running 50 load generators for 1 hour/day:
- Traditional: 50 VMs × 24/7 × $0.10/hour = **$3,600/month**
- Cloud (Fargate): 50 containers × 1 hour/day × $0.04/hour = **$60/month**
- **Savings: $3,540/month (98%)**

### Phase 3: Full Orchestration & Auto-Scaling 🌟 **(Future State)**
- Trigger tests from CI/CD pipelines
- Auto-scale based on load requirements
- Multi-region distributed testing
- Infrastructure-as-Code (GitOps)
- **Total Cost Reduction: 85-95%** vs traditional

---

## 🖥️ Docker Installation (Windows)

Before you can run this platform, you need Docker Desktop installed on your Windows machine.

### Step 1: Download Docker Desktop

1. Visit: **https://www.docker.com/products/docker-desktop/**
2. Click **"Download for Windows"**
3. Save the installer file (Docker Desktop Installer.exe)

### Step 2: Install Docker Desktop

1. **Run the installer** (Docker Desktop Installer.exe)
2. **Check the boxes** for:
   - ✅ Use WSL 2 instead of Hyper-V (recommended)
   - ✅ Add shortcut to desktop
3. Click **"OK"** and wait for installation to complete
4. **Restart your computer** when prompted

### Step 3: Start Docker Desktop

1. **Launch Docker Desktop** from your desktop or Start menu
2. **Accept the license agreement** if prompted
3. Wait for Docker to start (you'll see a whale icon in your system tray)
4. You may need to install **WSL 2** if prompted:
   - Click the link in the Docker Desktop prompt
   - Run: `wsl --install` in PowerShell (as Administrator)
   - Restart your computer

### Step 4: Verify Installation

Open **PowerShell** or **Command Prompt** and run:

```bash
docker --version
docker-compose --version
```

You should see version numbers like:
```
Docker version 24.x.x
Docker Compose version v2.x.x
```

✅ **Docker is ready!** You can now run the performance testing platform.

### Troubleshooting Docker Installation

| Issue | Solution |
|-------|----------|
| **"WSL 2 installation is incomplete"** | Run `wsl --install` in PowerShell as Administrator, then restart |
| **Docker Desktop won't start** | Enable Virtualization in BIOS (Intel VT-x or AMD-V) |
| **"Docker daemon is not running"** | Right-click Docker Desktop icon → Restart |
| **Permission errors** | Add your user to "docker-users" group (Computer Management → Local Users and Groups) |

**Still stuck?** Visit: https://docs.docker.com/desktop/troubleshoot/overview/

---

## ⚡ Getting Started (So Easy, Anyone Can Do It!)

### Prerequisites Checklist

- ✅ Docker Desktop installed and running (see above)
- ✅ At least 4GB RAM available on your machine
- ✅ Internet connection (for initial download)

---

### 🎯 3-Step Setup

#### Step 1: Get the Project

**Option A:** Download as ZIP
1. Click the green **"Code"** button on GitHub → **"Download ZIP"**
2. Extract to a folder (e.g., `C:\PerformanceTesting\jmeter-distributed-grid`)

**Option B:** Clone with Git
```bash
git clone <your-repo-url>
cd jmeter-distributed-grid
```

---

#### Step 2: Open Terminal in Project Folder

1. Navigate to the folder where you extracted/cloned the project
2. **Right-click** inside the folder → **"Open in Terminal"** (or PowerShell)
3. You should see your terminal path ending with `jmeter-distributed-grid`

---

#### Step 3: Start the Platform

Copy and paste this command:

```bash
docker-compose up -d
```

**That's it!** ✨ The platform is now running.

---

### ✅ Verify Everything Is Running

Run this command to check status:

```bash
docker-compose ps
```

You should see **5 containers running**:
- `jmeter-master` - The test coordinator
- `jmeter-slave_1` - Load generator #1
- `jmeter-slave_2` - Load generator #2
- `influxdb` - Metrics storage database
- `grafana` - Visual dashboard

**All should show "Up" status** ✅

---

### 📊 Access Your Dashboard

Open your web browser and go to:

**http://localhost:3000**

- **Username:** admin
- **Password:** admin

(You can change this later if you want)

Navigate to: **Dashboards → Browse → JMeter folder → JMeter Performance Dashboard**

You now have a professional monitoring dashboard! 🎉

---

## 🧪 Running Your First Performance Test

Now let's run a sample test to see everything in action.

### Run the Test

Copy and paste this command:

```bash
docker-compose exec jmeter-master jmeter -n -t /scripts/sample_test.jmx -r
```

**What this does:**
- Connects to the JMeter master container
- Runs the sample test (`sample_test.jmx`)
- Uses `-r` to automatically distribute load across all slaves
- Sends metrics to InfluxDB in real-time

### Alternative: Manual Method (Understanding the Configuration)

If you want to see exactly which slaves are being used, you can specify them manually.

**First, scale to 5 slaves:**
```bash
docker-compose up -d --scale jmeter-slave=5
docker-compose restart jmeter-master
```

**Then run a test with explicit slave names:**
```bash
docker-compose exec jmeter-master jmeter -n -t /scripts/Testing_1.jmx -R jmeter-distributed-grid-jmeter-slave-1,jmeter-distributed-grid-jmeter-slave-2,jmeter-distributed-grid-jmeter-slave-3,jmeter-distributed-grid-jmeter-slave-4,jmeter-distributed-grid-jmeter-slave-5
```

**What this shows:**
- You can see exactly which 5 slaves are executing the test
- Each slave name follows the pattern: `jmeter-distributed-grid-jmeter-slave-N`
- This demonstrates how the automatic `-r` flag works behind the scenes
- **Recommended:** Use the automatic `-r` method (simpler!), but this manual method helps understand the configuration


### Watch It Run

You'll see output like:
```
Creating summariser <summary>
Created the tree successfully using /scripts/sample_test.jmx
Starting distributed test...
summary +    156 in 00:00:05 =   31.2/s
summary +    324 in 00:00:10 =   32.4/s
summary =    480 in 00:00:15 =   32.0/s
Tidying up...
```

### View Results in Grafana

1. Refresh your Grafana dashboard (**http://localhost:3000**)
2. You'll now see:
   - ✅ **Response times** (average, 90th, 95th, 99th percentile)
   - ✅ **Throughput** (requests per second)
   - ✅ **Error rates** (success vs failures)
   - ✅ **Active threads** (concurrent users)
   - ✅ **Transaction breakdown** (performance by operation)

**Congratulations!** 🎊 You've just run a distributed performance test with real-time monitoring.

---

## 📈 Scaling Your Load Generators

One of the biggest advantages of this platform is **instant scaling**.

### Why Scale?

- **More load generators = More concurrent users**
- **50 slaves can simulate 50,000+ concurrent users** (depending on test complexity)
- Traditional approach: Provision 50 VMs (weeks) ❌
- Container approach: Scale to 50 (5 seconds) ✅

---

### Scaling Commands

#### Scale UP to 5 Load Generators
```bash
docker-compose up -d --scale jmeter-slave=5
docker-compose restart jmeter-master
```

#### Scale UP to 10 Load Generators
```bash
docker-compose up -d --scale jmeter-slave=10
docker-compose restart jmeter-master
```

#### Scale DOWN to 1 Load Generator (Save Resources)
```bash
docker-compose up -d --scale jmeter-slave=1
docker-compose restart jmeter-master
```

#### Scale to ZERO (Testing Setup Only)
```bash
docker-compose up -d --scale jmeter-slave=0
```

**Note:** After scaling, always restart the master so it can discover the new slaves.

---

### Real-World Scenarios

| Scenario | Slaves Needed | Command |
|----------|---------------|---------|
| **Smoke Test** (light load) | 1-2 | `--scale jmeter-slave=1` |
| **Load Test** (normal traffic) | 3-5 | `--scale jmeter-slave=5` |
| **Stress Test** (peak traffic) | 10-20 | `--scale jmeter-slave=20` |
| **Spike Test** (traffic surge) | 30-50 | `--scale jmeter-slave=50` |

---

## 🏗️ Architecture Overview (Simplified)

```
┌──────────────────────────────────────────────────────────────┐
│                    Your Docker Network                        │
│                                                                │
│  ┌─────────────┐      ┌─────────────┐  ┌─────────────┐       │
│  │   JMeter    │─────→│   JMeter    │  │   JMeter    │       │
│  │   Master    │      │   Slave 1   │  │   Slave 2   │       │
│  │ (Coordinator)      │ (Generator) │  │ (Generator) │       │
│  └──────┬──────┘      └──────┬──────┘  └──────┬──────┘       │
│         │                    │                │               │
│         └────────────────────┼────────────────┘               │
│                              ↓                                │
│                     ┌─────────────────┐                       │
│                     │    InfluxDB     │                       │
│                     │ (Metrics Store) │                       │
│                     └────────┬────────┘                       │
│                              ↓                                │
│                     ┌─────────────────┐                       │
│                     │     Grafana     │◄──── You view here   │
│                     │  (Dashboard)    │      (localhost:3000) │
│                     └─────────────────┘                       │
└──────────────────────────────────────────────────────────────┘
```

### Component Explanation

| Component | What It Does | Why You Need It |
|-----------|--------------|-----------------|
| **JMeter Master** | Coordinates the test, distributes work to slaves | Brain of the operation |
| **JMeter Slaves** | Generate actual load (HTTP requests, etc.) | The muscle - more slaves = more load |
| **InfluxDB** | Stores all test metrics (time-series database) | Keeps historical data for analysis |
| **Grafana** | Displays beautiful, real-time dashboards | Makes data visual and actionable |

**All four components run as lightweight containers and can scale independently.**

---

## 🔧 Creating Your Own Tests

The sample test is just a demo. Here's how to create your own:

### Option 1: Use JMeter GUI (Recommended for Beginners)

1. **Download JMeter** on your local machine:  
   https://jmeter.apache.org/download_jmeter.cgi

2. **Create your test plan** using the JMeter GUI:
   - Add Thread Groups (virtual users)
   - Add Samplers (HTTP requests, etc.)
   - Add Listeners for local testing

3. **Add InfluxDB Backend Listener** (Critical!):
   - Right-click Test Plan → Add → Listener → Backend Listener
   - Implementation: `org.apache.jmeter.visualizers.backend.influxdb.InfluxdbBackendListenerClient`
   - **influxdbUrl:** `http://influxdb:8086/write?db=jmeter`
   - **application:** Your app name (e.g., "MyWebApp")
   - **testTitle:** Unique test name (e.g., "Load_Test_v1")

4. **Save as `.jmx` file** in the `scripts/` folder

5. **Run your test:**
   ```bash
   docker-compose exec jmeter-master jmeter -n -t /scripts/YourTest.jmx -r
   ```

### Option 2: Edit Existing Scripts

Modify `scripts/sample_test.jmx` or `scripts/Testing_1.jmx`:
- Change target URLs
- Adjust thread counts (virtual users)
- Modify think times and ramp-up periods

---

## 📁 Project Structure

```
jmeter-distributed-grid/
├── docker-compose.yml          # Defines all services (master, slaves, InfluxDB, Grafana)
├── Dockerfile                  # JMeter container image definition
├── entrypoint.sh               # Auto-discovers slaves on startup
├── .gitignore                  # Excludes data folders from version control
│
├── configs/                    # JMeter configuration files
│   ├── jmeter.properties       # JMeter global settings
│   └── user.properties         # Custom user properties
│
├── scripts/                    # Your JMeter test scripts (.jmx files)
│   ├── sample_test.jmx         # Demo test with InfluxDB integration
│   └── Testing_1.jmx           # Another example test
│
├── grafana-provisioning/       # Auto-configures Grafana on startup
│   ├── datasources/            # InfluxDB connection config
│   └── dashboards/             # Pre-built performance dashboards
│
├── data/                       # Persistent storage (survives container restarts)
│   ├── influxdb/               # All test metrics stored here
│   └── grafana/                # Dashboard settings and preferences
│
└── results/                    # Local test result files (optional)
```

---

## 🛠️ Troubleshooting

### Dashboard Shows No Data

**Cause:** You haven't run a test yet, or test didn't send data to InfluxDB.

**Solution:**
1. Run a test: `docker-compose exec jmeter-master jmeter -n -t /scripts/sample_test.jmx -r`
2. Check InfluxDB is running: `docker-compose ps influxdb` (should show "Up")
3. Verify test script has InfluxDB Backend Listener configured
4. Check JMeter logs: `docker-compose logs jmeter-master`

---

### Cannot Access Grafana (http://localhost:3000)

**Cause:** Port 3000 might be in use, or Grafana isn't running.

**Solution:**
1. Check Grafana status: `docker-compose ps grafana`
2. Check if port is in use: `netstat -an | findstr :3000`
3. View Grafana logs: `docker-compose logs grafana`
4. Restart Grafana: `docker-compose restart grafana`

---

### Slaves Not Discovered or Not Responding

**Cause:** Slaves might not be running, or master hasn't refreshed.

**Solution:**
1. Check slave status: `docker-compose ps | findstr slave`
2. Check if slaves were discovered: `docker-compose logs jmeter-master | findstr "Found slave"`
3. Restart master to re-discover: `docker-compose restart jmeter-master`
4. View slave logs: `docker-compose logs jmeter-slave_1`

---

### Out of Memory Errors

**Cause:** Too many slaves or too many virtual users for available RAM.

**Solution:**
1. Reduce number of slaves: `docker-compose up -d --scale jmeter-slave=2`
2. Reduce thread count in your JMeter test plan
3. Allocate more RAM to Docker Desktop:
   - Open Docker Desktop → Settings → Resources → Memory
   - Increase to 8GB or more
   - Click "Apply & Restart"

---

### Test Runs But No Metrics in InfluxDB

**Cause:** Backend Listener not configured correctly.

**Solution:**
1. Open your `.jmx` file in JMeter GUI
2. Check Backend Listener settings:
   - URL must be: `http://influxdb:8086/write?db=jmeter`
   - Make sure "application" and "testTitle" are filled
3. Re-save and try again

---

### Docker Commands Not Recognized

**Cause:** Docker Desktop not running or not in PATH.

**Solution:**
1. Start Docker Desktop (check system tray for whale icon)
2. Wait for Docker to fully start (icon should be static, not animated)
3. Restart your terminal/PowerShell

---

## 🧹 Managing Your Environment

### Stop Everything (Keeps Data)
```bash
docker-compose down
```
**Note:** Your test data in `data/influxdb` and `data/grafana` is preserved.

---

### Start Everything Again
```bash
docker-compose up -d
```
**Note:** All your historical data will still be available in Grafana.

---

### Reset Everything (Delete All Data)
```bash
docker-compose down -v
Remove-Item -Recurse -Force data\influxdb, data\grafana
docker-compose up -d
```
**Warning:** This deletes all historical test data permanently!

---

### View Logs (Debugging)
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs jmeter-master
docker-compose logs grafana
docker-compose logs influxdb

# Follow live logs
docker-compose logs -f jmeter-master
```

---

### Rebuild After Code Changes
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## 📊 Data Persistence

Your test data **automatically persists** between container restarts!

### What's Preserved

- ✅ **All InfluxDB metrics** (stored in `./data/influxdb/`)
- ✅ **Grafana dashboards and settings** (stored in `./data/grafana/`)
- ✅ **User preferences and customizations**

### How It Works

Docker mounts these folders from your host machine into the containers. Even if you:
- Run `docker-compose down`
- Rebuild images
- Restart your computer

**Your data remains safe** as long as the `data/` folder exists.

### Backing Up Your Data

```bash
# Create a backup
xcopy /E /I data data_backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%
```

### Restoring from Backup

```bash
# Stop containers
docker-compose down

# Restore data
xcopy /E /I data_backup_YYYYMMDD\influxdb data\influxdb
xcopy /E /I data_backup_YYYYMMDD\grafana data\grafana

# Restart
docker-compose up -d
```

---

## 🎯 Next Steps & Customization

### Customize Grafana Dashboards

1. Log into Grafana (http://localhost:3000)
2. Open the JMeter dashboard
3. Click the ⚙️ icon → "Dashboard settings"
4. Add/remove panels, change colors, thresholds, etc.
5. Click **"Save dashboard"**

Your changes are automatically persisted!

---

### Create Custom JMeter Properties

Edit `configs/jmeter.properties` or `configs/user.properties` to customize:
- Thread pool settings
- HTTP connection timeouts
- SSL configurations
- Plugin properties

Restart containers to apply changes:
```bash
docker-compose restart jmeter-master
```

---

### Integrate with CI/CD

Add this to your Jenkins/GitLab CI/Azure Pipelines:

```bash
# Start platform
docker-compose up -d --scale jmeter-slave=10

# Wait for discovery
sleep 10
docker-compose restart jmeter-master
sleep 5

# Run test
docker-compose exec -T jmeter-master jmeter -n -t /scripts/YourTest.jmx -r

# Collect results
docker-compose exec -T influxdb influx -execute 'SELECT * FROM jmeter' -database=jmeter > results.txt

# Teardown
docker-compose down
```

---

### Migrate to Cloud

When ready for **Phase 2** (cloud migration):

**AWS (Fargate/ECS):**
- Convert docker-compose to ECS task definitions
- Use AWS Fargate for serverless containers
- Store data in RDS/S3

**Azure (AKS):**
- Convert to Kubernetes manifests
- Deploy to Azure Kubernetes Service
- Use Azure Monitor for logging

**GCP (GKE):**
- Create Kubernetes configs
- Deploy to Google Kubernetes Engine
- Integrate with Stackdriver

---

## 📞 Support & Resources

### Official Documentation
- **JMeter:** https://jmeter.apache.org/usermanual/index.html
- **Docker:** https://docs.docker.com/
- **Grafana:** https://grafana.com/docs/
- **InfluxDB:** https://docs.influxdata.com/influxdb/v1.8/

### Learning Resources
- JMeter Distributed Testing: https://jmeter.apache.org/usermanual/remote-test.html
- Docker Compose: https://docs.docker.com/compose/
- Grafana Dashboards: https://grafana.com/tutorials/

---

## 📝 Summary: Why This Matters

This platform demonstrates a **fundamental shift** in how enterprise infrastructure operates:

### Traditional Mindset
- Buy hardware upfront
- Provision for peak capacity
- Pay for idle resources
- Manual scaling = weeks

### Modern Mindset (This Project)
- Use containers
- Provision on-demand
- Pay only when running
- Instant scaling = seconds

**This isn't just about performance testing.** It's a proof of concept for:
- Infrastructure modernization
- Cloud readiness
- DevOps practices
- Cost optimization

**Show your manager:**
1. How easy it is to get running (3 commands)
2. The instant scaling demo (2 slaves → 20 slaves in 5 seconds)
3. The professional dashboards (http://localhost:3000)
4. The cost savings analysis (70-95% reduction)

**Then explain:** This same containerization approach applies to:
- Application deployments
- Development environments
- Testing environments
- Production workloads

**You're not just building a testing platform.** You're demonstrating the future of IT infrastructure. 🚀

---

## 🏆 Success Metrics

After implementing this solution, you can measure success by:

| Metric | Before (VMs) | After (Containers) | Improvement |
|--------|--------------|-------------------|-------------|
| **Provisioning Time** | 2-4 weeks | 2 minutes | 99.9% faster |
| **Scaling Time** | 2-3 hours | 5 seconds | 99.9% faster |
| **Idle Cost** | ~$8K/year | $0 | 100% savings |
| **Maintenance Hours** | 8 hrs/month | 15 min/month | 97% reduction |
| **Onboarding Time** | Days | Minutes | 99% faster |
| **Infrastructure Flexibility** | Low | High | ∞ improvement |

---

**Ready to impress your manager? Just run:**

```bash
docker-compose up -d
```

**That's all it takes.** ✨
