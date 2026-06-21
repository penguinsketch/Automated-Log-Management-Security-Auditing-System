# Automated-Log-Management-Security-Auditing-System

This project uses **Bash Script** to automate log management and security auditing. It collects critical logs, analyzes suspicious activities, and generates fast security reports for administrators.

This project is developed and running on **Linux Mint**.

### 🚀 Phase 1: Creating the Script and Setting up the Base Code

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

