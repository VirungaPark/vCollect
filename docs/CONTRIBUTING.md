# Contributing Guide

How to set up, code, test, review, and release so contributions meet our Definition of Done.

## Code of Conduct

- Be direct and respectful in issues, pull requests, and reviews. Critique the code, not the person.
- Conflicts should be resolved as follows: name the issue, speak directly to team member(s), involve the team, escalate to the instruction team.

## Getting Started

**Prerequisites:** Flutter 3.47.9 (the exact version CI uses, pinned in `app/pubspec.yaml`) with Dart `^3.13.7`, which ships with Flutter; Android Studio including the Android SDK; an Android emulator or physical Android device; Git. CI builds the APK with JDK 17\.

1. Clone the repository: `git clone https://github.com/VirungaPark/vCollect.git`
2. Install dependencies: `cd vCollect/app && flutter pub get`
3. Connect an Android device or start an emulator. Android Studio can also use the shared run configuration in `.run/`.
4. Run app locally: `flutter run` (from `app/`)
5. Confirm set up works by running tests: `flutter test` (from `app/`)&nbsp;

**Secrets:** No secrets are needed to build or run the app today, and there is no `.env` file. When credentials or API keys are introduced, they live only in the team's agreed secrets store and in an untracked local file. Add an `.env.example` and update this section in the same PR. Never paste secrets into chat, issues, PRs, or any AI tool.

**Data:** Never use real Virunga Park or user data in development, tests, or screenshots. Use synthetic data only.

If any step fails, ask in Teams then fix this section in the same PR that resolves it.

## Branching & Workflow

We use trunk-based development with short-lived branches and `main` as the default branch.

Branch protection on `main` is a strict rule. The Quality Owner configures it and these settings must stay on:

- Changes reach `main` only through a pull request
- Each pull request needs at least 1 approving review before merging; the author cannot approve their own PR.
- New commits pushed to a PR dismiss earlier approvals.
- Required status checks (see CI/CD) must pass and the branch must be up to date with `main`.
- force pushes and branch deletion are blocked on `main`.

**Branch names:** `type/issue#shortDescription`, for example: `feat/24speciesSearch`. Types are `feat`, `fix`, `docs`, `test`, `refactor`.

**Process:**

1. Branch from latest `main`.
2. Commit small and often.
3. Rebase onto `main` to keep branch current; never rebase or force-push a branch someone else is reviewing without communicating.
4. Merge using **squash and merge**, so each PR becomes one commit on `main`. Delete the branch after merging.

## Issues & Planning

- Every piece of work has an issue on the GitHub Project board before a branch is opened. Board link: \[add the board link here\].
- File issues using the templates in `.github/ISSUE_TEMPLATE/` (Bug, Feature, Documentation): problem or goal, acceptance criteria, and any partner spec reference.
- Labels: `feature`, `bug`, `documentation`, with a size label `S`, `M`, `L`.
- Size: `S` is under half a day, `M` is up to two days, and `L` must be split before the sprint starts.
- The Project Manager triages new issues at each Friday meeting and assigns them. Anyone may pick up an unassigned issue after saying so in Teams.
- Questions the specification document can't answer need to be communicated to the project partner at the Monday meeting, or through Email.

## Commit Messages

We use Conventional Commits: `type(scope): short summary`, in the imperative mood and under 80 characters.

```
feat(search): add species name filter
fix(map): prevent crash when location is missing
docs(readme): add local setup steps
```

Reference issues in the PR description.

## Code Style, Linting & Formatting

- **Formatter:** `dart format`.
- **Linter:** `flutter analyze`, using the `flutter_lints` rules configured in `app/analysis_options.yaml`.
- **Check locally (from `app/`):** `dart format --set-exit-if-changed .` and `flutter analyze`
- **Auto-fix locally:** `dart format .` and `dart fix --apply`
- CI re-runs both checks on every PR. A pre-commit hook that runs both before each commit is not set up yet (see Definition of Done).

## Testing

- **Required test types:** unit and widget tests in `app/test/`. Integration tests are required once offline storage and sync exist.
- **Run all tests (from `app/`):** `flutter test`
- **Run one file:** `flutter test test/widget_test.dart`
- **New or changed behavior needs a test in the same PR**, and every bug fix needs a test that fails without the fix.
- **Accessibility:** touch targets are checked with Flutter's tap-target guideline test on each screen (NFR-6).
- **Coverage:** \[team to set a target, for example 70%\] on new code, enforced by CI once the coverage gate lands. No coverage gate exists yet.
- Tests use synthetic data only.

## Definition of Done

A change merges only when every check below passes. Each check is tied to what enforces it. Gates that don't exist yet are named with the sprint they land in and who owns them.Until a gate exists, the reviewer checks it by hand and says so in the review.

| Check | Enforced by | Status | Owner |
| :---- | :---- | :---- | :---- |
| Changes go through a PR into `main` | Branch protection: pushes to `main` blocked | In place (reported in the Sprint 2 note) | Alex |
| At least 1 approving review from a teammate other than the author | Branch protection: required reviews \= 1, stale approvals dismissed | In place (reported in the Sprint 2 note) | Alex |
| All review conversations resolved | Branch protection: require conversation resolution | In place (reported in the Sprint 2 note) | Alex |
| Lint and format pass | CI job "Format and analyze" in `.github/workflows/app-ci.yml`; pre-commit hook | CI job in place. Hook not added yet; the team picks the sprint | Alex |
| Tests pass | CI job "Unit tests" | In place. Integration tests land once the first storage and sync code exists | Alex |
| New or changed behavior has tests | Reviewer checks the PR checklist; coverage gate | Reviewer check now; gate not added yet, the team picks the sprint | Alex |
| No secrets in the diff | "Secret Scan" workflow (gitleaks over the full history) plus the PR checklist | In place | Tashfia |
| Dependencies free of known vulnerabilities and permissively licensed | CI job "Dependency licenses" (MIT, BSD-2-Clause, BSD-3-Clause, Apache-2.0, ISC, Zlib, including transitive packages); Dependabot weekly update PRs | In place. Also confirm Dependabot and vulnerability alerts are on in the repository settings | Alex |
| Docs updated (README, ADRs, CHANGELOG as needed) | PR checklist, checked by the reviewer | Now | Nolan |
| Decisions that are expensive to reverse have an ADR | PR checklist, checked by the reviewer. ADRs live in `docs/adr/` | Now. First ADRs planned: encryption and key handling, `dart_jts` spike | Nolan |
| PR is linked to an issue with acceptance criteria met | PR template (`.github/PULL_REQUEST_TEMPLATE.md`) | Template added with this change | Sophia |

Until a gate exists, the reviewer checks it by hand and says so in the review.

## Contribution Norm

Where work lives & what "accepted" means:

- Code and tests: This repository; accepted when the PR is merged and meets the definition of done.
- Documentation: This repository; accepted when the PR is merged and a teammate has reviewed it.
- Decisions: This repository under `vCollect/docs/`; accepted when docs are merged and linked from the issue.
- Partner communication: Teams and the board; notes and findings are posted and the PM marks the issue as done.

## Pull Requests & Reviews

**Opening a PR:**

- Use the PR template in `.github/PULL_REQUEST_TEMPLATE.md`.
- Keep PRs focused, ideally under 400 changed lines, and split larger changes.
- Link the issue, describe what changed and how you tested it, and tick the checklist (tests, docs, no secrets).
- Request one teammate as a reviewer; preferably someone who didn't work on the change.

**Reviewing:**

- Review within 48 hours of being requested; aim for 24\.
- Check the code does what the issue's acceptance criteria say, that it's readable, and that it's tested.
- Leave specific comments, and mark each comment as blocking or a suggestion.
- Approve only when you'd be comfortable maintaining the code yourself.

**Merging:**

- Merge requires the approval and passing checks listed in the Definition of Done, and the author merges after approval.
- If a review stalls, ping the reviewer in Teams, then ask the PM to reassign.

## CI/CD

- **Pipeline definitions:** `.github/workflows/app-ci.yml` (app) and `.github/workflows/secret-scan.yml`; the shared Flutter setup is in `.github/actions/setup-flutter/`.
- **Jobs:** "Format and analyze", "Unit tests", "Dependency licenses" and "Debug APK" (runs after the first two) run only when a PR changes files under `app/` or the CI workflow files. "Gitleaks" runs on every PR. Add new jobs to this list as they land.
- **Required checks and docs-only PRs:** because the app jobs are skipped on a docs-only PR, a branch-protection rule that requires them can leave such a PR waiting forever. Check which jobs are required in branch protection, and either require only "Gitleaks" plus the app jobs that always run, or remove the `paths:` filter from `app-ci.yml`.
- **Debug APK:** the "Debug APK" job builds an arm64 APK. Download it from the run's summary page; it is kept for 7 days.
- **View logs / rerun:** open the PR, click **Checks**, choose the job, and use **Re-run jobs**.
- **Before merge:** all required jobs pass and branch protection is satisfied.
- **Before release** CI is green on `main` and the Quality Owner confirms the demo path works.
- A failing `main` build is the Quality Owner's first priority, and everyone must help fix it as soon as possible.

## Security & Secrets

- **Reporting a vulnerability:** Message the Quality Owner and PM privately in Teams, don't file a public issue. If it could expose Virunga Park or user date, the PM informs the project partner immediately
- **Never commit:** synthetic or real data, passwords, API keys, `.env` files. `.env` must be in the `.gitignore`.
- If a secret is committed, tell the Quality Owner immediately, rotate the secret, and don't solely rely on deleting the commit. The secret scan checks the full git history, so a secret removed in a later commit still fails.
- **Dependencies:** `Dependabot` opens update PRs, which are reviewed like any other PR. Add new dependencies only after a team decision, and check the license first: CI only allows MIT, BSD-2-Clause, BSD-3-Clause, Apache-2.0, ISC and Zlib.
- **AI tools:** Follow `AGENTS.md`. Never put Virunga Park or user data, credentials, or unapproved code into an AI tool. If you are unsure, ask the AI Coordinator first.

## Documentation Expectations

Update these in the same PR as the change:

- `README.md`: Setup, run, usage changes.
- `docs/DESIGN.md`: Architecture, data, sync and security changes.
- `docs/REQUIREMENTS.md`: Changes to requirements, constraints or open questions.
- `docs/RISK.md`: Reviewed at each sprint planning; update when a risk moves or closes.
- `docs/` in general: Anything a new contributor would need.
- `docs/CHANGELOG.md`: For user-visible changes, once the first release exists.
- `docs/AGENTS.md`: When conventions or commands change.&nbsp;

Use the exact file names in `docs/` (`DESIGN.md`, `REQUIREMENTS.md`, `RISK.md`); GitHub paths are case-sensitive.

## Release Process

Describe versioning scheme, tagging, changelog generation, packaging/publishing steps, and rollback process.

- **Version naming**: Follow Semantic Versioning conventions (MAJOR.MINOR.PATCH).
  - Major \- breaking architectural updates.
  - Minor \- new features/significant enhancements.
  - Patch \- bug fixes, small changes.
- **Releases**: Tagged using Git annotated tags `vx.x.x`. Never push a release to main without a release PR and approval from maintainers.
- **Change-logs**: Generated and appended to `vCollect/docs/CHANGELOG.md` using conventional git commits ('feat:', 'fix:', 'docs', etc.). Ensure that commits/PRs follow the 'Pull Requests & Reviews' section.
- **Packaging/publishing**: Ensure all tests pass on main before generating and attaching the app bundle, release notes, and tagged binary to the new release entry in the repository's GitHub Releases section. Today CI only produces a debug arm64 APK; a release build, its signing, and the distribution channel are not decided yet (see RISK R-3), so until they are, attach the CI debug APK.
- **Rollback process**: If a critical bug is discovered after release:
  1. Identify the failure and open an issue in the GitHub project.
  2. Revert the problematic commit and remove the faulty release.
  3. Once resolved, issue a patch release bumping the version num (x.x.1).

## Support & Contact

For questions about this project contact one of the contributors via the emails below:&nbsp;  
[sahlstra@oregonstate.edu](mailto:sahlstra@oregonstate.edu), [schereso@oregonstate.edu](mailto:schereso@oregonstate.edu), [tabassut@oregonstate.edu](mailto:tabassut@oregonstate.edu), [cutlern@oregonstate.edu](mailto:cutlern@oregonstate.edu)

Expect responses within 24 hours on business days.