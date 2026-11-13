---
description: After each git push, run unit + widget + integration tests, update graphify graph and log push history
---

# /opsx-git — Push guarded by tests → graph update + push history

Before each push on your branch, run tests. Push only if all pass.

## Steps

1. **Run unit + widget tests**
   ```bash
   flutter test test/
   ```
   Covers `test/widget_test.dart` (widget tests) and all unit tests under `test/`.

2. **Run integration tests**
   ```bash
   flutter test integration_test/
   ```

3. **Guard — block push on failure**
   - If any test fails: **do not push**. Report failures, stop here.
   - Only on success: proceed to push.

4. **Push**
   ```bash
   git push origin $(git rev-parse --abbrev-ref HEAD)
   ```

5. **Update the architecture graph** (after successful push)
   - Code changed → refresh graph:
     ```bash
     graphify update .
     ```
   - Full fresh build if needed:
     ```bash
     graphify extract . --code-only
     ```

6. **Write push history into `graphify-out/push-history/`**
   - Per-push entry: `graphify-out/push-history/<UTC timestamp>-<short sha>.json`
   - Fields: `timestamp`, `sha`, `branch`, `message`, `graph`.

7. **Confirm** — tests passed, graph updated, history saved.

## Behavior

- Invoked via `/opsx-git` before pushing.
- Push guarded by `flutter test test/` + `flutter test integration_test/`.
- Each successful push → graph update → push history entry in `graphify-out/push-history/`.
