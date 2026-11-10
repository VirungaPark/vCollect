# AGENTS.md

This is the cross-tool source of truth for AI-assisted work. Point to the corresponding documentation in the repo to avoid duplication. Read this file and `CONTRIBUTING.md` before making changes.

## Project context

The team is developing an application using the Flutter framework for agronomists to collect agricultural-field information, capture field perimeters and optionally access routes, operate with limited connectivity, and transfer validated records to a project PostGIS database on AWS. The partner is the Virunga Foundation, with staff in Europe and Africa; coordination may involve an approximately nine-hour time difference and delayed replies.

The partner has identified an NDA/IP requirement and notes sensitive information that could put rangers or staff at risk. **This is a strict boundary, not a generic caution.** The final signed NDA, partner data agreement, and instructor directions take precedence over assumptions in this file.

## Known / not yet confirmed

- Confirmed project direction: Android first; Flutter code kept iOS-compatible; field boundaries and optional access paths; offline support is a core requirement; PostGIS on AWS is the target database.
- The knowns and unknowns for the project's technical decisions can be found in `vCollect/docs/DESIGN.md`.
- The existing iCollect application is difficult to maintain and its data is not controlled by the project team. Do not assume its source, schema, API, or credentials are available or authorized for reuse.
- Owners to fill in: Project Manager (PM) — **\[name\]**; AI Coordinator — **\[name\]**; Quality Owner — **\[name\]**. The role owner must approve changes to this file’s owned area. Team roster and additional subsystem owners are recorded in the team charter.

## Confidentiality and AI-use rules

Until the partner provides written approval naming specific AI services and the team confirms that approval against the signed NDA/IP terms:

1. **Never send** real or linkable farmer identities, plot/field boundaries or coordinates, access routes, ranger locations or routes, production records, partner datasets, private partner meeting notes, credentials, tokens, keys, database dumps, private repository contents, or NDA-protected code/documents to any external AI service, public chatbot, code assistant, or model API.
2. Do not use real partner records in prompts, issue descriptions, logs, test fixtures, screenshots, telemetry, crash reports, or demos. Use fabricated synthetic data that cannot be linked to a real person, field, or route.
3. Public, non-sensitive project facts may be used in public AI tools only if their source is genuinely public and the prompt reveals no confidential context. Generic programming questions and independently written toy examples are allowed; do not paste project code while tool approval is unresolved.
4. **Approved tools for confidential partner material: none confirmed yet.** Local/private tools are not automatically approved; local storage, retention, logging, and model configuration must also be checked against partner requirements before use.
5. If uncertain, do not paste. Ask the AI Coordinator, who checks the written partner agreement and obtains partner clarification where needed. “We were unsure” is not permission.
6. If a suspected disclosure occurs, stop further sharing, preserve relevant evidence without recirculating the material, notify the AI Coordinator and instructor immediately, and follow the partner/institution incident process. Do not silently delete, edit, or conceal the incident.

The partner said verbally on 2026-10-26 that AI use is permitted without sensitive information. That is not written approval, so the rules above stay in force (docs/RISK.md, R-11).

## Engineering instructions for AI tools

- Do not invent user stories, partner requirements, data fields, access permissions, CRS, topology rules, retention periods, security controls, or synchronization semantics. Flag assumptions and propose questions for the PM to confirm.
- Prefer offline-first behavior in design discussion, but distinguish a proposal from an implemented/validated capability. Consider interrupted sessions, device loss, duplicate sync, conflict resolution, and retry safety.
- Treat geometry and precise location as sensitive. Do not add example coordinates drawn from partner fields; use clearly synthetic geometries.
- Do not print, commit, log, or request secrets. Never connect to production databases or perform destructive/production writes.
- For database or API changes, recommend migration, least-privilege access, input validation, auditability, and tests against synthetic data; do not claim these are implemented until evidence exists.
- Do not weaken validation or tests merely to make a build pass. Summarize uncertain choices and required human/partner review.
- Follow the branch, review, Definition of Done, and Contribution Norm in `CONTRIBUTING.md`.
- Do not add dependencies without a team decision, and check each package's license against the CI allowlist above.&nbsp;
- Reach the backend only through the single sync interface described in docs/DESIGN.md (section 4.1). Do not hard-code assumptions about an API that Virunga has not provided.
- Follow the branch, review, Definition of Done, and Contribution Norm in CONTRIBUTING.md.

## Maintenance owners and updates

- **AI Coordinator \[name\]** owns this file and the confidentiality boundary. Before using a new AI service or allowing new data classes, obtain written authorization and update this file with tool names, allowed content, and limitations.
- **Documentation owner \[name\]** keeps the pointers and commands above current whenever the stack, commands, CI or device requirements change.
- **Data/sync owner \[name\]**, after partner confirmation: add the approved schema/API/CRS and offline synchronization constraints, without copying sensitive record data.