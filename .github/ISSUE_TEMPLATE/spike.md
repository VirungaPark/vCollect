---
name: Spike
about: A time-boxed investigation of a library or software to decide whether it fits
  our needs
title: "[SPIKE]"
labels: ''
assignees: ''
type: Task

---

## Description
<!-- Which library or software are we evaluating, and what need or risk prompted this? Example: dart_jts, for polygon closure, self-intersection and overlap checks. -->

## Questions to answer
<!-- What must this spike confirm? Each question should have a clear yes/no or measurable answer. -->
1.
2.
3.

## Time box
<!-- The most time we will spend on this. Example: 2 days. When it runs out, stop and report what you have, even if the answer is "inconclusive". -->

## Evaluation criteria
<!-- Keep the ones that apply, add any specific to this spike, and state thresholds where you can. Example: validates a 500-vertex polygon in under 200 ms on the Pixel 7 emulator. -->
- [ ] Supports every operation listed under Questions to answer
- [ ] Works on Android with our pinned Flutter and Dart versions
- [ ] Works offline, with no network calls
- [ ] Performance is acceptable on our target devices
- [ ] License is one we allow (MIT, BSD-2-Clause, BSD-3-Clause, Apache-2.0, ISC, Zlib), including transitive packages
- [ ] No known vulnerabilities, and actively maintained (recent releases, issues getting responses)

## Approach
<!-- How you plan to test it: sample data, a throwaway branch, benchmarks. Optional. -->

## Acceptance criteria
- [ ] Every question above is answered with evidence (code, test results, or benchmarks)
- [ ] Findings are written up under Findings and recommendation below
- [ ] A recommendation is made: adopt, adopt with changes, or reject
- [ ] Spike code is linked from this issue and is not merged to `main` unless the team decides to keep it
- [ ] Follow-up issues are filed, and an ADR is added in `docs/adr/` if the decision is expensive to reverse

## Findings and recommendation
<!-- Fill this in when the spike is done. -->
**Recommendation:** <!-- Adopt / Adopt with changes / Reject / Inconclusive -->

**Summary:**

**Evidence:** <!-- Links to branch, tests, benchmarks. -->

**Gaps or risks:**

**Next steps:**

## Additional context
<!-- Related issues, risk register entry, design doc section, alternatives to compare against. -->
