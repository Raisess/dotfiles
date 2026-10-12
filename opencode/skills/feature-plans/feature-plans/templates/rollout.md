# Rollout and Rollback: <Feature Name>

Create this document for features with migrations, operational risk, external integrations, or staged releases.

## Release Strategy

- **Deployment order:** <Services/jobs/migrations>
- **Feature flag:** <Name, default, owner, or none>
- **Audience/stages:** <Internal, percentage, cohorts, all users>
- **Prerequisites:** <Configuration, secrets, dependencies>

## Data Migration

- **Migration:** <Schema/data change or none>
- **Backward compatibility:** <How old and new versions coexist>
- **Backfill:** <Strategy, batching, checkpoints, validation>
- **Recovery:** <How to recover from partial failure>

## Monitoring

- **Signals:** <Errors, latency, throughput, business metrics>
- **Alerts:** <Thresholds and owner>
- **Success criteria:** <Observable indicators>

## Rollback Plan

1. <Trigger for rollback>
2. <Disable feature or revert release>
3. <Handle data/schema compatibility>
4. <Verify recovery and communicate status>

## Operational Checklist

- [ ] Configuration and secrets are available.
- [ ] Migrations have been reviewed and tested.
- [ ] Monitoring and alerts are ready.
- [ ] Rollback has been reviewed.
- [ ] Support/runbook documentation is updated.
