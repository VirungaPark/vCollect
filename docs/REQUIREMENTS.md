# <!-- gdoc_comment_begin: c1 -->Requirements<!-- gdoc_comment_end: c1 -->

## Problem Statement

Virunga Park needs an app that lets field agents record thousands of farmers, their fields and their trees, far from any network in the DRC. It sends everything to a database when the agent is back online and is the starting point of traceability to reach compliance with international markets and protect the park.

## Functional requirements

Priority labels below use MoSCoW: need to the product, not build order.

| <!-- gdoc_comment_begin: c2 -->ID<!-- gdoc_comment_end: c2 --> (FR-\#) | Priority | Statement | Acceptance Criteria |
| :---- | :---- | :---- | :---- |
| FR-1 | Must: app data must be secure. | A user opens the app and signs in using their Virunga ID and passcode. | An unregistered ID or incorrect passcode is denied. |
| FR-2 | Must: main workflow, nothing else works without it. | An agent opens and fills out a new form with date, time, location, and farmers information. | The data in the form is saved locally. Form is queued for sync. |
| FR-3 | Must: data needs to persist between sessions, otherwise it needs to be collected again. | An agent opens an existing form and completes the remaining steps. | Data from the agent's previous session persists. Incomplete forms are not sent to the backend. |
| FR-4 | Must: core feature, app is useless without the cloud. | An agent connects to WiFi: app syncs with the database. | Completed forms are pushed to the database. Modified forms and assignments are pulled to the app. No data is lost during sync. |
| FR-5 | Must: farmers can have multiple fields. | The agent can add one or more fields per farmer, each with its own crops, boundary walk, access path, trees or counts, and one screen per section (environment, inputs, condition, management, ownership, certification).&nbsp; | Two fields can be added to one farmer, each with its own crops, boundary and section screens, and both show on the farmer's file. |
| FR-6 | Must: core feature, app couldn’t render forms, identity files, or maps without this function. | On sync, the phone receives the campaign package: published forms, people and fields already known in the agent's zones, the offline map and a block of Virunga IDs.&nbsp; | After one sync on Wi-Fi, in airplane mode the agent can open a known person, open a form, view the map and create a new record with an ID.&nbsp; |
| FR-7 | Should: helpful to the Agent but could be done automatically (completed files removed after set time) | The app shows package size before download and lets the agent remove old packages. | The size is shown before the download starts. Removing an old package frees its storage and the app still works with the current one.&nbsp; |
| FR-8 | Must: one of the core collection features. | An agent traces a field. | Incomplete and intersecting boundary lines and overlaps with other fields are not accepted. Traced boundary is drawn and persists on map. |
| FR-9 | Must: a core collection feature. | An agent traces a field entry path. | Traced path is drawn and persists on map. |
| FR-10 | Must: required for data integrity | An agent can only see the zones of their campaigns, cannot delete anything, and cannot validate their own records. | An agent has no access to other zones and no delete or validate-own action.&nbsp; |
| FR-11 | Should: helpful for staff but not integral to apps main functionality. | An administrator creates a new form: adds a new attribute type, controls the order of questions through the app. | No code changes or new releases required. |
| FR-12 | Should: helpful for staff but not integral to apps main functionality. | An administrator edits an existing form: removes a question, adds a new one, adds instructions/images/audio all through the app. | No code changes or new releases required. Changes persist and once approved can be seen by Agents. Forms completed in the previous version remain unchanged. |
| FR-13 | Must: integral for data integrity. | Every configuration change is logged with who, what and when. | Each change appears in the log with all three. |
| FR-14 | Must: part of the main functionality included in campaign packages. | A traceability manager can create a campaign with a name, zones, dates, record types and assigned agents.&nbsp; | The role can do each listed action.&nbsp; |
| FR-15 | Must: adding new farmer identities is impossible without this. | The phone creates IDs offline from a block that the cloud reserves for it at each sync. The farmer leaves the visit with their final ID.&nbsp; | The phone creates IDs offline from a block that the cloud reserves for it at each sync. The farmer leaves the visit with their final ID. |
| FR-16 | Should: helpful but not required as long as cloud sync exists. | Data can be exported in GeoPackage or GeoJSON for the GIS team. | An export file opens in GIS software with the expected shapes. |
| FR-17 | Must: prevent data loss. | Data is removed from the phone only after the cloud confirms it has it.&nbsp; | A record is retained on the phone until approval. |

Priority labels below use MoSCoW: need to the product, not build order.

| ID (FR-\#) | Priority | Statement | Acceptance Criteria |
| :---- | :---- | :---- | :---- |
| FR-1 | Must: app data must be secure. | A user opens the app and signs in using their Virunga ID and passcode. | An unregistered ID or incorrect passcode is denied. |
| FR-2 | Must: main workflow, nothing else works without it. | An agent opens and fills out a new form with date, time, location, and farmers information. | The data in the form is saved locally. Form is queued for sync. |
| FR-3 | Must: data needs to persist between sessions, otherwise it needs to be collected again. | An agent opens an existing form and completes the remaining steps. | Data from the agent's previous session persists. Incomplete forms are not sent to the backend. |
| FR-4 | Must: core feature, app is useless without the cloud. | An agent connects to WiFi: app syncs with the database. | Completed forms are pushed to the database. Modified forms and assignments are pulled to the app. No data is lost during sync. |
| FR-5 | Must: farmers can have multiple fields. | The agent can add one or more fields per farmer, each with its own crops, boundary walk, access path, trees or counts, and one screen per section (environment, inputs, condition, management, ownership, certification).&nbsp; | Two fields can be added to one farmer, each with its own crops, boundary and section screens, and both show on the farmer's file. |
| FR-6 | Must: core feature, app couldn’t render forms, identity files, or maps without this function. | On sync, the phone receives the campaign package: published forms, people and fields already known in the agent's zones, the offline map and a block of Virunga IDs.&nbsp; | After one sync on Wi-Fi, in airplane mode the agent can open a known person, open a form, view the map and create a new record with an ID.&nbsp; |
| FR-7 | Should: helpful to the Agent but could be done automatically (completed files removed after set time) | The app shows package size before download and lets the agent remove old packages. | The size is shown before the download starts. Removing an old package frees its storage and the app still works with the current one.&nbsp; |
| FR-8 | Must: one of the core collection features. | An agent traces a field. | Incomplete and intersecting boundary lines and overlaps with other fields are not accepted. Traced boundary is drawn and persists on map. |
| FR-9 | Must: a core collection feature. | An agent traces a field entry path. | Traced path is drawn and persists on map. |
| FR-10 | Must: required for data integrity | An agent can only see the zones of their campaigns, cannot delete anything, and cannot validate their own records. | An agent has no access to other zones and no delete or validate-own action.&nbsp; |
| FR-11 | Should: helpful for staff but not integral to apps main functionality. | An administrator creates a new form: adds a new attribute type, controls the order of questions through the app. | No code changes or new releases required. |
| FR-12 | Should: helpful for staff but not integral to apps main functionality. | An administrator edits an existing form: removes a question, adds a new one, adds instructions/images/audio all through the app. | No code changes or new releases required. Changes persist and once approved can be seen by Agents. Forms completed in the previous version remain unchanged. |
| FR-13 | Must: integral for data integrity. | Every configuration change is logged with who, what and when. | Each change appears in the log with all three. |
| FR-14 | Must: part of the main functionality included in campaign packages. | A traceability manager can create a campaign with a name, zones, dates, record types and assigned agents.&nbsp; | The role can do each listed action.&nbsp; |
| FR-15 | Must: adding new farmer identities is impossible without this. | The phone creates IDs offline from a block that the cloud reserves for it at each sync. The farmer leaves the visit with their final ID.&nbsp; | The phone creates IDs offline from a block that the cloud reserves for it at each sync. The farmer leaves the visit with their final ID. |
| FR-16 | Should: helpful but not required as long as cloud sync exists. | Data can be exported in GeoPackage or GeoJSON for the GIS team. | An export file opens in GIS software with the expected shapes. |
| FR-17 | Must: prevent data loss. | Data is removed from the phone only after the cloud confirms it has it.&nbsp; | A record is retained on the phone until approval. |

## Non-functional requirements

| ID (NFR-\#) | Priority | Statement |
| :---- | :---- | :---- |
| NFR-1 | Must: app must work offline due to field conditions. | Every field function works with 0 network connection: search, registration, photos, boundary walk, trees, check visits, signatures, maps, ID creation and geofence tests.&nbsp; |
| NFR-2 | Should: slow is tolerable, no data loss is the real priority. | Once connected to a WiFi network, each completed form is synced to the database in under 2 seconds.&nbsp; |
| NFR-3 | Should: slow is tolerable. | Each view is rendered in under 1 second. |
| NFR-4 | Should: slow is tolerable, but must work. | Searching the people in the agent’s zones on the phone returns results in under 1 second. |
| NFR-5 | Must: Field work can take the entire day, users cannot capture data if their device has no power.&nbsp; | The app consumes under 5% battery per hour of continuous tracking. |
| NFR-6 | Should: agents are assumed to be first-time smartphone users working outdoors, often standing.&nbsp; | Each touch target is at least 48 dp, and every primary action works without a long press, swipe, or two-finger gesture. Checked with Flutter’s tap-target guideline test on every screen. |
| NFR-7 | Must: necessary for authentication and security of data. | After 30 days with no sync, the app asks the agent to sign in again. |

Constraints

| ID (C-\#) | Description |
| :---- | :---- |
| C-1 | The app functions entirely offline. |
| C-2 | Collected data is encrypted at rest. |
| C-3 | Nothing is overwritten; every collection confirms or updates data; every change retains old values, author, date, location. |
| C-4 | Signatures are signed on the screen through the app; tied to the data it confirms. |
| C-5 | Cloud is AWS: a PostgreSQL database with PostGIS holds the reference data. |
| C-6 | Remains lightweight, used by devices with little storage. |
| C-7 | Needs to be compatible with both Android and iOS devices. |
| C-8 | Needs to be compatible with external GPS receivers that send NMEA. |
| C-9 | The app is built with Flutter. |
| C-10 | Positions are stored in WGS 84 with at least 6 decimal places |
| C-11 | The team works with synthetic data only, never real farmer data. Anything else Virunga shares is covered by the NDA. |

## Success metrics

Targets are proposals; Virunga and the team will set final numbers after the first field tests

* Record lost during sync: 0\. Counted over the automated sync tests, including 50 records created in airplane mode, then synced, and a sync cut off mid-way. Every record must arrive exactly once, any loss is a failure.  
* Unaided registration: at least 4 of 5 test agents, after a short training, complete one farmer and one field offline without help. Observed in usability tests, with time per registration and number of mistakes recorded and compared with iCollect (if possible) as a baseline.  
* Form change without a developer: a new question is added and published by an administrator and appears on a phone after its next sync, with 0 code changes and 0 new app releases. Demonstrated once per form change tested.

## Non-goals

* Importing the data already held in iCollect.  
* Links to other Virunga systems. The design must not block them later: records can be imported in bulk and the API is documented in OpenAPI  
* Forest cover and deforestation analysis, which Virunga’s GIS team handles separately.  
* Face or fingerprint recognition.

## Open questions

* Who validates records, the supervisor or the traceability manager? Owner: Valentin Pierson, before validation workflow is built.  
* Is an overlap with another field blocked or kept with a note for the supervisor to decide? Owner: Valentin, before FR-8 is built.  
* Where do administrators and traceability managers configure forms and campaigns: in the mobile app, or in a web back-office (listed as a stretch goal in the design document)? Owner: team with Valentin, before the first form is built  
* Which form schema format do we use for versioned JSON forms? Owner: team, before form development begins  
* Does the capstone deliver and test an iOS build, or only keep the Flutter code iOS-compatible? Owner: Valentin, before Repo Checkpoint 2  
* Which tree species are inventoried and which are counted, and are trees in scope for the capstone project at all? Owner: Valentin, before FR-5 Is scheduled  
* <!-- gdoc_comment_begin: c3 -->What are the Virunga ID format and issuing rules?<!-- gdoc_comment_end: c3 --> A placeholder format is used until decided. Owner: Valentin, before FR-17 is finished.  
  * Example format, to be decided. V-4827-1936-5. The first eight digits come from the phone's block. The final 5 is the check digit. (section 6.1 of spec document)  
* What AWS database endpoints can we connect to or what environment can we access? Owner: Valentin, before the walking skeleton is deployed (Repo Checkpoint 2\)  
* What is the license and distribution plan (design document proposes MIT and an APK)? Owner: Valentin and team, to be agreed upon before the first release.
