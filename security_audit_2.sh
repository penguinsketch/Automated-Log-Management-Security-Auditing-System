LOG_FILE="/home/user/audit_report.txt"
TARGET_DIR="/var/log/myapp"

echo "--- Security Audit Started at $(date) ---" > $LOG_FILE
echo "Status: Monitoring active" >> $LOG_FILE
echo "Scanning for old logs in $TARGET_DIR..." >> $LOG_FILE
find $TARGET_DIR -name "*.log" -type f -mtime +7 >> $LOG_FILE
