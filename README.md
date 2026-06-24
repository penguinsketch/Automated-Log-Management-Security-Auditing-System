# Automated-Log-Management-Security-Auditing-System

This project uses **Bash Script** to automate log management and security auditing. It collects critical logs, analyzes suspicious activities, and generates fast security reports for administrators.

This project is developed and running on **Linux Mint**.

## 🚀 Phase 1: Creating the Script and Setting up the Base Code

In this step, we create the `security_audit.sh` file and write the initial base structure.

**Command:** nano security_audit.sh

Add this code into the script file
![Creating Script](./code1.png)

* `LOG_FILE="/home/admint/audit_report.txt"`                  : Defines the path where the audit report file will be saved.
* `echo "---Security Audit Start at $(date) ---" > $LOG_FILE` : Creates the report file and records the exact start date and time.
* `echo "Status: Monitoring active" >> $LOG_FILE`             : Appends the current system monitoring status to the end of the file.

**Making the Script Executable**
To run the script, you need to change its file permissions using the `chmod`
**Command:** chmod +x security_audit.sh

**Note:** Using `chmod +x` grants executable permissions to the file, allowing the system to run it as a program.
Use code with caution.

Run the script and verify the output by using the following 
**Commands:**
./security_audit.sh

The command output will look like this
![Output Script](./outputcode1.png)

## 🔍 Phase 2: Log Filtering and Management (The Filtering Logic)
Clean up expired logs to free up storage without affecting critical system files.

* **`find`**: Best for scanning and bulk-deleting residual files based on conditions (e.g., daily log cleanup).
* **`sleep && rm`**: Best for delayed deletion of a specific file like a "time bomb" (e.g., removing a temporary file 5 minutes after use).
Use code with caution.

#### Example: Managing files older than 7 days in `/var/log/myapp`
Add this code into the script file

![Output Script](./code_2.png)

* `TARGET_DIR="/var/log/myapp"`                                   : Defines the target directory path where the script will search for log files.
* `echo "Scanning for old logs in $TARGET_DIR..."` >> $LOG_FILE   : Appends a progress message to the report file, showing which directory is being scanned.
* `find $TARGET_DIR -name "*.log" -type f -mtime +7` >> $LOG_FILE : Searches for .log files older than 7 days in the target directory and appends the list of found files to the report.

* **`-name "*.log"`**: Restricts the search to files ending with the `.log` extension.
* **`-type f`**: Limits the search to "files" only (excluding directories) for safety.
* **`-mtime +7`**: Finds files last modified more than 7 days ago.
* **`-mmin +5`**: Finds files older than 5 minutes (perfect for quick testing without waiting 7 days).
Use code with caution.

**Note:** Never use the `-delete` option right away. Always verify that your `find` command targets the correct files first. It is highly recommended to output (echo) the file list into a log file for review before executing any actual deletion.

Run the script and verify the output by using the following 
**Commands:** 
./security_audit.sh

The command output will look like this 
![Output Script](./outputcode2.png)

The output does not show any `.log` files because of the `-mtime +7` condition, which looks for files older than 7 days. Since our test files were created just 5 minutes ago, they do not match the criteria and are excluded from the search results.

## ⏰ Phase 3: Automating the System with Crontab
Instead of manually running the script every day, we can register it as a scheduled task in the system (via Crontab) to automatically execute the log cleanup script every midnight.

**Method 1: The Standard Approach (Manual Editor)** 

Open the Crontab configuration editor by running: `crontab -e`

Scroll to the bottom of the file and append the following line (make sure to replace `/path/to/` with your actual script path): `0 0 * * * /path/to/security_audit.sh`

**Method 2: The Pro Approach**
In Cloud Security operations, setups are often automated across multiple systems. You can use Linux Pipes (`|`) and Redirection to inject the task into Crontab instantly without opening an interactive editor: `(crontab -l 2>/dev/null; echo "0 0 * * * /path/to/security_audit.sh") | crontab -`

Add this into the crontab -e file
![Output Script](./code3.png)

```text
 0   0   *   *   *   /path/to/security_audit.sh
 │   │   │   │   │   └─ Path to the script execution file
 │   │   │   │   └─ Day of the week (Every day)
 │   │   │   └─ Month (Every month)
 │   │   └─ Day of the month (Every day)
 │   └─ Hour (0 = Midnight / 12:00 AM)
 └─ Minute (0 = Minute zero)
```

* **`0 0 * * *`**: Schedules the task to run automatically **every day at midnight (00:00)**.
* **`/path/to/security_audit.sh`**: Specifies the absolute path to the script that will be executed.

### 🔍 Verification

1. **Check the Queue**: After setup, run `crontab -l` to verify that your script has been successfully registered in the system's schedule.
2. **Await Automation**: Wait for the scheduled execution time (e.g., midnight) to trigger.
3. **Verify the Output**: Check your `audit_report.txt` file. You should see new log entries appended automatically without any manual intervention.

![Output Script](./outputcode3.png)

### 📊 Phase 4: Reporting & Auditing Setup
To consolidate all results into a single file, we will optimize the script to structure the audit report into 3 clean sections:

* **Header**: Records the exact system start timestamp.
* **Body**: Displays the list of detected stale log files queued for management.
* **Footer**: Appends a confirmation timestamp once the operation completes successfully.

Here is the complete production-ready script combining all components from Phases 1–3 into a structured, well-formatted workflow:
![Output Script](./code4.png)

### 1. Define the variables and file locations for the report.
```
REPORT_FILE="/home/admint/Security_report.txt"
TARGET_DIR="/var/log/myapp"
```

### 2. Begin saving the report (use > to start a new file each time it is run) 
```
echo "================================================" > $REPORT_FILE
echo "Security Audit Report - Generated on $(date)" >> $REPORT_FILE
echo "================================================" >> $REPORT_FILE
```

### 3. Check the files that meet the criteria (SOC Logic: Look at the list before actually deleting) 
```
echo "Found the following logs for deletion (Older than 7 days):" >> $REPORT_FILE
find $TARGET_DIR -name "*.log" -type f -mtime +7 >> $REPORT_FILE
```

### 4. Order to delete the actual file (this step requires you to be sure before entering -delete) 
```
find $TARGET_DIR -name "*.log" -type f -mtime +7 -delete
```

### 5.Summary of the report's findings.
```
echo "================================================" >> $REPORT_FILE
echo "Status: Cleanup Completed Successfully." >> $REPORT_FILE
```
