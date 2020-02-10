# pcf-sre
Pipeline, application, and dashboard for Site reliability engineering (SRE)

# Pre-req
- Concourse
- Prometheus/Grafana
- Configure and deploy the metrics collector application
- build docker image from Dockerfile

# Steps
- push metrics collector app
- create a metrics collector username/password
- assign user as SpaceDeveloper role where application has been deployed
- create concourse pipeline
- add scrape endpoint to prometheus
- add dashboards to grafana

# Results
## Pipeline
![](images/pipeline.jpg)

## Dashboard
![](images/dashboard.jpg)

## Scrape config
```
- job_name: service_metrics
  scheme: https
  scrape_interval: 30m
  static_configs:
  - targets:
    - metricscollector.apps.xyz.domain.com
```

## Metric application results
https://metricscollector.apps.xyz.domain.com/metrics
```
# HELP credhub_svc_creation_availability Credhub SLI gauge use to collect Credhub SLIs
# TYPE credhub_svc_creation_availability gauge
credhub_svc_creation_availability 1
# HELP docker_metric_success Docker SLI gauge use to collect Docker SLIs
# TYPE docker_metric_success gauge
docker_metric_success 0
# HELP ecs_metric_success ECS SLI gauge use to collect ECS SLIs
# TYPE ecs_metric_success gauge
ecs_metric_success 1
```