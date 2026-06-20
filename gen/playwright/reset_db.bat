@echo off
echo Resetting database...
if exist logs\traffic.db del logs\traffic.db
if exist logs\traffic.db-shm del logs\traffic.db-shm
if exist logs\traffic.db-wal del logs\traffic.db-wal
mkdir logs 2>nul
echo Database reset. Run python run.py to recreate it.
pause