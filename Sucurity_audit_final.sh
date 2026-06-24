#!/bin/bash

REPORT_FILE="/home/admint/Security_report.txt"
TARGET_DIR="/var/log/myapp"

echo "================================================" > $REPORT_FILE
echo "Security Audit Report - Generated on $(date)" >> $REPORT_FILE
echo "================================================" >> $REPORT_FILE

 
echo "Found the following logs for deletion (Older than 7 days):" >> $REPORT_FILE
find $TARGET_DIR -name "*.log" -type f -mtime +7 >> $REPORT_FILE
 
find $TARGET_DIR -name "*.log" -type f -mtime +7 -delete

echo "================================================" >> $REPORT_FILE
echo "Status: Cleanup Completed Successfully." >> $REPORT_FILE
