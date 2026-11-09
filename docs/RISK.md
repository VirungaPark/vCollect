# Risks

Last updated: 2026-11-08

**What we are trying to deliver:** an app that lets agronomists record farmers, fields, boundaries, and visits on their phones without a connection, and then send that data safely into Virunga's existing PostGIS environment through their API. We start with Android and the Flutter framework.

**How to read this page.** It is the one risk register for the project, and it is written so our partner can read it too. Risks are listed from most to least pressing. Each one is rated for how likely it is and how much it would hurt (High, Medium, or Low), with a plain reason. Each has one owner, who keeps an eye on it and says something when it moves, and a trigger, the sign that it is turning into a real problem. When a risk depends on an answer from Virunga, we say who we asked and when. We review the top of this list at every sprint planning. Our contact with our project partner is Valentin, and we meet weekly on Mondays.

# Open risks

## Open Risk Priority List

* R-14: Dart_JTS is an in-progress port of JTS  and needs to be tested  
* R-1: Field data could be lost or overwritten during offline sync  
* R-2: We don't have the partner's API details yet  
* R-4: The NDA is unsigned, and it says the repository stays private  
* R-3: We may have no way to install a build on a device outside the team  
* R-7: Switching to Flutter means a steep ramp-up on mapping  
* R-11: Our AI-use rule is only a verbal one  
* R-5: Phones in the field can be lost, and encryption has no design yet  
* R-6: We can't test GPS the way the partner will use it  
* R-9: Answers from the partner take about a day  
* R-10: Our docs are behind our code  
* R-13: Our own AWS account costs money and comes with a deletion duty

&nbsp;

## Open Risk List

### R-1: Field data could be lost or overwritten during offline sync

**Technical · Likelihood High · Impact High.** Offline use is the heart of the app, nobody on the team has built it before, and field data can't easily be collected again.

Agronomists will work for most of a day with no connection, and sometimes upload several forms with photos at once. If a session is cut off, an upload is retried, or two phones change the same record, a form or a field boundary could be lost, doubled, or overwritten. That would break our own rule that nothing is overwritten and every change keeps its old value.

- **Owner:** Alexander  
- **What we're doing:** building offline-first on local storage with made-up data, writing the conflict, retry, and queue rules into `docs/design.md`, and testing interrupted and duplicate uploads.  
- **If it happens anyway:** if sync still isn't reliable by the sprint 3 review, we ship record capture with a manual export and leave automatic sync out of the first release.  
- **We'll know it's happening when:** there's still no passing sync test on made-up data by 2026-11-23.

### R-2: We don't have the partner's API details yet

**Technical · Likelihood Medium · Impact High.** The app has to talk to their API, and so far we're guessing at what it looks like.

We haven't received an endpoint specification (an OpenAPI document, for example) or a preview environment, and we don't know how sign-in and sessions work. If the mock API we build against differs from the real one, we'll end up redoing integration work late in the term.

- **Owner:** Tashfia  
- **Who we asked:** Valentin, on 2026-10-26. He agreed to request it from their tech team. We'll ask again at the 2026-11-09 meeting, as the TA suggested on 2026-10-30.  
- **What we're doing:** building against a mock API behind a single interface, so swapping in the real one is a small change.  
- **If it happens anyway:** if nothing arrives by 2026-11-23, we treat the mock as our written contract and ask the partner to confirm it.  
- **We'll know it's happening when:** there's still no specification or preview environment on 2026-11-09.

### R-3: We may have no way to install a build on a device outside the team

**Business · Likelihood Medium · Impact High.** The milestone for "deployed" is a build that installs on someone else's device.

The partner's field phones are rugged Samsung models on Android 15, and we don't have one. Virunga told us on 2026-10-23 that the distribution option is theirs to decide, and iOS is out of scope in their design. If we haven't agreed on a channel and a tester by week 10, we can't show the working skeleton on a device outside the team.

- **Owner:** Sophia  
- **Who we asked:** Valentin, before 2026-10-23, in our Questions and Requests document. They haven't decided yet. On 2026-11-09 we'll propose a release page or a Play test track and ask for one outside tester.  
- **What we're doing:** shipping Android first.  
- **If it happens anyway:** if there's no channel by 2026-11-23, we ask the instructors for an agreed equivalent milestone.  
- **We'll know it's happening when:** the channel or tester is still undecided on 2026-11-23.

### R-4: The NDA is unsigned, and it says the repository stays private

**Business · Likelihood Medium · Impact High.** The terms touch every student personally, and they conflict with the plan to open the code later.

Each of us signs separately, and nobody has signed yet. The NDA says the repository must stay private and nothing from Virunga goes public without their written agreement, yet the partner's own design says the code becomes public under an open licence at the end. It also asks us to return or delete confidential material when the project ends, and it runs for five years afterward. If we sign before the repository question is settled, we're each bound to terms the team hasn't agreed to.

- **Owner:** Tashfia  
- **Who we asked:** Valentin, before 2026-10-23, about making the repository public. The TA asked on 2026-10-23 for the point to be clarified before anyone signs. On 2026-10-26 the partner said it is fine to submit class assignments without sensitive information. We still need their written agreement on the repository.  
- **What we're doing:** getting that agreement in writing, then signing; keeping partner material out of the repository; keeping a list of where confidential copies live.  
- **If it happens anyway:** if it isn't settled by 2026-11-09, the repository stays private and we don't publish anything until Virunga agrees in writing.  
- **We'll know it's happening when:** the NDA is still unsigned after the 2026-11-09 meeting, or someone starts using partner material before signing.

### R-5: Phones in the field can be lost, and encryption has no design yet

**Technical · Likelihood Medium · Impact Medium.** We use no real data during the project, so the real exposure comes at handoff.

The finished app will keep records, boundaries, and visits on the phone until they sync, and "encrypted at rest" is one of our stated constraints. We haven't designed it yet.

- **Owner:** Nolan  
- **What we're doing:** accepting this for the prototype, and writing a short design decision (ADR) on encryption and key handling before we build real-format storage.  
- **If it happens anyway:** if the ADR is late, we state the gap plainly in the handoff so the partner knows the data isn't encrypted yet.  
- **We'll know it's happening when:** there's no encryption ADR by 2026-11-23.

### R-6: We can't test GPS the way the partner will use it

**Technical · Likelihood Medium · Impact Medium.** Accuracy decides whether our boundary checks are fair to the agronomists.

The partner gave us GPS-quality and overlap thresholds on 2026-10-23, but said external GPS receivers will be hard to lend, and we have no field phone to test on. So support for external receivers, and the battery limit, can't really be checked. If real-world accuracy is worse than we assumed, our checks might reject good fields or accept bad ones.

- **Owner:** Sophia  
- **Who we asked:** Valentin, before 2026-10-23. He answered that lending receivers is unlikely.  
- **What we're doing:** proposing on 2026-11-09 that external receiver support be an interface for the first release, tested only with the phone's own GPS. That would remove most of this risk.  
- **If it happens anyway:** if the partner needs external receivers, we'll ask for a loaned device or a recorded sample.  
- **We'll know it's happening when:** we still have no tracing test on a physical Android phone by 2026-11-23.

### R-7: Switching to Flutter means a steep ramp-up on mapping

**Team · Likelihood Medium · Impact High.** Our own sprint notes name this as our top risk.

We moved from native Android to Flutter and Dart, which resets our UI and local-storage plans, and mapping and GPS libraries are the part we know least. The TA asked for a bare-minimum prototype running on an Android device by the end of this week. If ramp-up runs long, our first working slice slips.

- **Owner:** Alexander  
- **What we're doing:** building one small prototype with a map, a GPS trace, and a local save; pairing on the first feature in each area; writing setup steps into `README.md` as we go.  
- **If it happens anyway:** if the prototype isn't running on a device by the review date, we shrink the first slice to forms and local save and push the map back.  
- **We'll know it's happening when:** nothing runs on a device by 2026-11-06.

### R-8: Our requirements may not match what the partner needs

**Business · Likelihood Medium · Impact Medium.** The whole objective depends on getting the requirements right.

Virunga returned decisions on our open design questions on 2026-10-23 and promised a requirement list with priority and timeline, but we haven't confirmed whether that list has arrived \[update: received / not received\]. Some items, like the supervisor check, may not be feasible. The app has to support English and French, and Virunga will supply Swahili. If we build the wrong things, the Must items slip.

- **Owner:** Sophia  
- **Who we asked:** Valentin, at the second partner meeting \[date of Meeting 2\].  
- **What we're doing:** marking unconfirmed requirements as "assumed" in `docs/requirements.md`, keeping a list of open questions, and confirming the Must items first.  
- **If it happens anyway:** we build the data-capture flow first and agree the rest at the next weekly meeting.  
- **We'll know it's happening when:** a Must item is still unconfirmed on 2026-11-23.

### R-9: Answers from the partner take about a day

**Business · Likelihood Medium · Impact Medium.** They are about nine hours ahead of us.

We meet on Mondays at 7:00 AM and talk through Teams, email, and GitHub Issues in between. A blocking question can cost us part of a sprint.

- **Owner:** Tashfia  
- **What we're doing:** accepting this. We send our questions in one batch before each Monday meeting and write down the working assumption next to each.  
- **If it happens anyway:** if a blocking question sits for 48 hours, we go ahead on the written assumption and flag it in the pull request.  
- **We'll know it's happening when:** a blocking question goes unanswered for 48 hours.

### R-11: Our AI-use rule is only a verbal one

**Technical · Likelihood Low · Impact High.** We have controls, but the rule isn't in writing.

On 2026-10-26 the partner told us AI use is permitted as long as we don't enter sensitive information. The NDA says confidential information can only be shared with the team, the TA, and course supervisors, and our `AGENTS.md` treats no AI service as approved. We don't expect to receive real data, but if real-looking data, credentials, or partner documents ended up in our repository or in an AI tool, we would be in breach of the NDA.

- **Owner:** Tashfia  
- **Who we asked:** Valentin, verbally, on 2026-10-26. On 2026-11-09 we'll ask for the rule in writing, naming tools and what content is allowed.  
- **What we're doing:** secret scanning on pull requests, made-up data only, the incident steps in `AGENTS.md`, and no partner documents in AI tools until we have it in writing.  
- **If it happens anyway:** we stop sharing, tell the AI Coordinator and the instructor, and let the partner know.  
- **We'll know it's happening when:** a scanner flags something, real-looking data shows up in a diff, or a partner document turns up in a prompt.

### R-13: Our own AWS account costs money and comes with a deletion duty

**Business · Likelihood Medium · Impact Medium.** The partner confirmed on 2026-10-23 that we use our own account.

If we haven't chosen and funded an account, we have nowhere to host a mock API. Under the NDA, anything confidential in that account also has to be returned or deleted when the project ends.

- **Owner:** Nolan  
- **What we're doing:** keeping the account small, with a budget alarm and infrastructure as code, so it can be redeployed in the partner's account later.  
- **If it happens anyway:** if costs go over our limit, we shut everything down except the mock API.  
- **We'll know it's happening when:** there's no account chosen by 2026-11-09, or a cost alert fires.

### R-14: Dart\_JTS is an in-progress port of JTS  and needs to be tested

**Technical** **· Likelihood Medium · Impact High**

Dart\_JTS is the port of the Java Topology Suite library that the team proposed using for topology checks (no intersecting boundaries, overlapping polygons, invalid polygons, etc.). It was pointed out by the partner on 11/3/26 that dart\_jts is not yet a complete port of the library and should be tested in a quick spike to ensure that it meets the app's requirements. If the library fails to meet our teams and project partner’s requirements then a new library will need to be chosen or the team will need to implement the logic themselves.

- **Owner:** Sophia  
- **What we’re doing:** the team has outlined the spike in [issue \#12](https://github.com/VirungaPark/vCollect/issues/12) and plan to complete the spike in either sprint 3 or sprint 4\.  
- **If it happens anyway:** if we do not perform a sprint and the library fails to meet the use cases or performance requirements the team/partner picks a new library or implements the needed logic themselves.  
- **We’ll know it’s happening when:** the team begins developing the field tracing feature and requires topology checks and the library does not hold a needed method or has a bug.

## What we're waiting on from others

| What we need | What it blocks | Who on our team | Asked of | When we asked | Start by | Where it stands |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| Signed NDA and written agreement on the repository (R-4) | Using partner material; open-sourcing | Tashfia | Valentin | NDA issued 2026-10-22; repository point raised before 2026-10-23 | 2026-11-09 | Unsigned; written agreement pending |
| API specification or preview environment (R-2) | Integration | Tashfia | Valentin | 2026-10-26 | 2026-11-09 | Waiting on their tech team |
| Team administrator, branch protection, CI plan (R-12) | CI and review gates | Alexander | Valentin | Before 2026-10-23 | 2026-11-09 | Replied 2026-10-23: normally fine; non-profit plan under consideration on 2026-10-26 |
| Distribution channel and outside tester (R-3) | The deployed milestone | Sophia | Valentin | Before 2026-10-23 | 2026-11-09 | Virunga to decide |
| AI-use rule in writing (R-11) | Using AI tools on project work | Tashfia | Valentin | Verbal answer 2026-10-26 | 2026-11-09 | Written confirmation not yet requested |
| Requirement list with priority and timeline (R-8) | Scope | Sophia | Valentin | \[date of Meeting 2\] | 2026-11-09 | \[received / not received\] |
| Marketing guide and sample data | UI and test data | Sophia | Valentin | 2026-10-26 | 2026-11-09 | Waiting |
| External GPS receiver for testing (R-6) | Receiver testing | Sophia | Valentin | Before 2026-10-23 | n/a | Not available |
| Permission to submit documents (R-4) | The checkpoint PDF | Tashfia | Valentin | 2026-10-26 | n/a | Answered 2026-10-26: fine without sensitive information |

## Where we test changes and how we undo them

- **Where changes get tried first:** an Android emulator against a mock API with made-up data, plus a real Android phone once we have one. We'll add the partner's preview environment when they provide it. This lands with the first prototype on 2026-11-06.  
- **Review before anything hard to undo** (schema, authentication, deployment, migrations): one approving review from someone other than the author, set in branch protection. This lands when branch protection is on, by the checkpoint due date.  
- **How we undo a bad change:** we revert the pull request and rebuild. After a release, we remove the faulty release and publish a patch release, as described in the Release Process in `CONTRIBUTING.md`. That's already written down, and we'll practice it once before the first release.

## Closed risks

A quick overview of which risks are closed and when.

| ID | Name | Synopsis | Date Closed |
| :---- | :---- | :---- | :---- |
| R-10 | Our docs are behind our code | [docs/desing.md](https://github.com/VirungaPark/vCollect/tree/main/docs) and [docs/README.md](https://github.com/VirungaPark/vCollect/tree/main/docs) are blank. | Documentation was completed 11/1/26. |
| R-12 | Nothing enforces review or tests yet | Repository set to private, restricting GitHub Action usage, only the project partner or TA could edit repository settings, the team lacked admin roles. No basic CI implemented. No project board. | 11/4/26 repository made public, branch protection enabled, and project board created (team still needs invites). 11/6/26 CI added to the repository and team made admin. |

&nbsp;

### Risk History:

### R-10: Our docs are behind our code

**Team · Likelihood Medium · Impact Medium.** The checkpoint compares our design document with a recent feature and follows our README from a clean clone.

Right now `docs/design.md` is empty and `README.md` is just a title, and file names and paths differ between our documents. If the docs keep lagging, we lose points on the Docs and Build Health criteria.

- **Owner:** Nolan  
- **What we're doing:** writing the design and quickstart for the scaffold now, and updating them in the same pull request as each change.  
- **If it happens anyway:** if the design isn't written by 2026-11-09, we describe the prototype's real structure first and the plan afterward.  
- **We'll know it's happening when:** a pull request changes behavior and merges without a docs change.

### R-12: Nothing enforces review or tests yet

**Technical · Likelihood High · Impact High.** The CI and board items are due now and neither exists.

Our repository is private because of the NDA, and the TA is its administrator, not one of us. Branch protection and GitHub Actions on a private repository depend on the partner's GitHub plan, so we may get limited CI minutes or no branch protection at all. We have no CI run and no project board yet, so those two checkpoint items are unmet.

- **Owner:** Alexander  
- **Who we asked:** Valentin, before 2026-10-23, to turn on branch protection, name one of us as administrator, and consider a public repository. He replied on 2026-10-23 that this should normally be fine, and on 2026-10-26 said Virunga was considering a non-profit GitHub plan for features like branch protection. No team administrator has been named yet.  
- **What we're doing:** setting up CI on a Flutter starter project with one test that fails when the scaffold breaks, creating the board, and turning on secret scanning and Dependabot.  
- **If it happens anyway:** if Actions are blocked, we document a local build-and-test command in `README.md` and ask the instructors for an equivalent milestone, with a date.  
- **We'll know it's happening when:** there's no CI run or board link by the checkpoint due date.