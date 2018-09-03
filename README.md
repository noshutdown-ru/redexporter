# Redexporter

Is a plugin for project management system Redmine.
Allows you to expose metrics from Redmine to Prometheus.

## List of metrics

```
# HELP load_average_one_minute Current load average at the time when the snapshot toke place.
# TYPE load_average_one_minute gauge
load_average_one_minute 0.00
```
```
# HELP disk_total_bytes Calculates the number of total bytes for the file system. This is the max. number of bytes possible on the device.
# TYPE disk_total_bytes gauge
disk_total_bytes 0
```

```
# HELP disk_used_bytes Calculates the number of used bytes for the file system.
# TYPE disk_used_bytes gauge
disk_used_bytes 1877413888
```

```
# HELP disk_free_bytes Calculates the number of free bytes for the file system.
# TYPE disk_free_bytes gauge
disk_free_bytes 38334705664
```

```
# HELP cpu_usage Cpu usage in percent.
# TYPE cpu_usage gauge
cpu_usage 0
```

```
# HELP redmine_files_bytes How much bytes redmine/files folder consume
# TYPE redmine_files_bytes gauge
redmine_files_bytes 36
```

```
# HELP redmine_sessions_count Number of sessions in the Redmine
# TYPE redmine_sessions_count gauge
redmine_sessions_count 1
```

```
# HELP redmine_user_count Number of users in the Redmine
# TYPE redmine_user_count gauge
redmine_user_count 2
```

```
# HELP redmine_all_issues_count Count of all issues
# TYPE redmine_all_issues_count gauge
redmine_all_issues_count 1
```

```
# HELP redmine_closed_issues_count Count of all closed issues
# TYPE redmine_closed_issues_count gauge
redmine_closed_issues_count 0
```

## About

https://noshutdown.ru/en/redmine-plugins-redexporter/#about

## Instalaltion

```
# cd redmine/plugins 
# git clone https://github.com/noshutdown-ru/redexporter.git
# cd ../
# bundle install --without development test
# rake redmine:plugins:migrate RAILS_ENV=production
```

## Screenshots

https://noshutdown.ru/en/redmine-plugins-redexporter/#screens

## Releases info

https://noshutdown.ru/en/redmine-plugins-redexporter/#releases
