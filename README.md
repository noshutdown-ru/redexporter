# Redexporter

A Redmine plugin that exposes comprehensive metrics to Prometheus for monitoring.

## Installation

```bash
cd redmine/plugins
git clone https://github.com/noshutdown-ru/redexporter.git
cd ../
bundle install --without development test
rake redmine:plugins:migrate RAILS_ENV=production
```

## Configuration

1. Go to Administration → Redexporter
2. Enable the plugin
3. Set a Prometheus token
4. Access metrics at: `/redexporter/metrics?token=YOUR_TOKEN`

## Metrics

### System Metrics

- `load_average_one_minute` - System load average for the last minute
- `cpu_usage` - CPU usage in percent
- `disk_total_bytes` - Total filesystem capacity in bytes
- `disk_used_bytes` - Used filesystem space in bytes
- `disk_free_bytes` - Free filesystem space in bytes

### Ruby/Rails Metrics

- `ruby_process_memory_bytes` - Process memory usage (RSS) in bytes
- `ruby_threads_count` - Number of active Ruby threads
- `ruby_gc_collections` - Total garbage collection cycles
- `ruby_heap_allocated_pages` - Allocated heap pages
- `ruby_heap_available_slots` - Available heap slots
- `ruby_live_objects` - Number of live Ruby objects in memory

### Redmine Core Metrics

- `redmine_projects_count` - Total number of projects
- `redmine_files_bytes` - Total size of files folder in bytes
- `redmine_sessions_count` - Active user sessions

### Issues Metrics (Multi-dimensional)

`redmine_issues{project="...",issue_type="...",status="...",priority="..."}` - Issues count by project, type, status, and priority

### Time Tracking Metrics

- `redmine_time_tracked_total_hours` - Total hours tracked across all issues
- `redmine_time_tracked_by_user_hours{user="..."}` - Hours tracked per user

### Users Metrics (Multi-dimensional)

- `redmine_users{status="...",role="...",group="..."}` - Users count by status, role, and group
- `redmine_users_total` - Total user count

User statuses:
- `active` - Active users
- `inactive` - No login in 30+ days
- `registered` - Registered but not yet active
- `locked` - Locked accounts

### Performance Metrics

- `redmine_average_request_latency_seconds` - Average HTTP request latency
- `redmine_max_request_latency_seconds` - Maximum HTTP request latency
- `redmine_request_count` - Total HTTP requests tracked

