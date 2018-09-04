# Redexporter

Is a plugin for project management system Redmine.
Allows you to expose metrics from Redmine to Prometheus.

## List of metrics

* load_average_one_minute Load average for last minute.
* disk_total_bytes Number of total bytes for the file system.
* disk_used_bytes Number of used bytes for the file system.
* disk_free_bytes Number of free bytes for the file system.
* cpu_usage Cpu usage in percent.
* redmine_files_bytes How much bytes redmine/files folder consume.
* redmine_sessions_count Number of sessions in the Redmine.
* redmine_user_count Number of users in the Redmine.
* redmine_all_issues_count Count of all issues in the Redmine.
* redmine_closed_issues_count Count of all closed issues in the Redmine.

## Demo and other plugins with Vagrant

[In this repo you can test our plugins without scare.](https://github.com/noshutdown-ru/vagrant_redmine)

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
