# Virunga Field Data Collection App

An offline-first Android application for collecting agricultural field data and supporting farm-level traceability for the Virunga Foundation.

## Overview

The Virunga Field Data Collection App is being developed to help field agents collect and manage agricultural data in areas with limited or unreliable internet connectivity.

The application is intended to support the registration of farmers and households, the mapping of agricultural fields, and the collection of related field information. By allowing agents to work offline and synchronize their records when connectivity becomes available, the app aims to make field data collection more reliable and accessible.

This project is being developed as part of Oregon State University's CS461 capstone course in collaboration with the Virunga Foundation.

## Features

The following features describe the project's intended functionality. Not all features are implemented yet.

### Core Features

- **Offline data collection:** Register and manage field records without an active internet connection.  
- **Farmer and household registration:** Collect information about farmers, household members, and associated homes.  
- **Field mapping:** Record agricultural field boundaries and access paths using device GPS.  
- **Geometry validation:** Check field boundaries for issues such as unclosed shapes, self-intersections, and overlaps.  
- **Area calculation:** Calculate field areas from recorded geographic boundaries.  
- **Data synchronization:** Upload locally collected records to a central database when connectivity is available.  
- **Record history and conflict handling:** Preserve record versions and identify conflicting updates rather than silently overwriting data.

### Additional Planned Features

- Data-driven forms that can be updated without rebuilding the application.  
- Offline map support.  
- External Bluetooth GPS receiver support.  
- Field visits and tree inventory collection.  
- Investigation of geofencing to support field verification.

A web-based supervisor interface is a potential stretch goal and is not a dependency of the mobile application.

## Technology Stack

| Component | Planned Technology |
| :---- | :---- |
| Mobile application | Flutter / Dart |
| Local database | SQLite with Drift |
| Local geographic data | Well-Known Binary (WKB) |
| Backend API | Python / FastAPI |
| Cloud database | PostgreSQL / PostGIS |
| Geographic API format | GeoJSON |
| Cloud infrastructure | AWS |
| Mapping | `flutter_map` with offline map support |
| Background synchronization | Workmanager |

The application is designed around an offline-first architecture. Data is stored locally on the device and synchronized with the backend when a connection is available.

For more information about the architecture, data model, synchronization approach, and technical decisions, see [`docs/design.md`](http://docs/design.md).

## Getting Started

### Prerequisites

To build and run the mobile application, you will need:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- [Android Studio](https://developer.android.com/studio), including the Android SDK  
- An Android emulator or physical Android device  
- Git

Verify your Flutter installation:

```sh
flutter doctor
```

### Installation

1. Clone the repository:

```sh
git clone https://github.com/VirungaPark/vCollect
```

Navigate to the Flutter project:

```sh
cd vCollect/app
```

Install the project dependencies:

```sh
flutter pub get
```

2. Connect an Android device or start an emulator.  
3. Run the application:

```sh
flutter run
```

> **Note:** The application is currently under development. Setup instructions and configuration requirements may change as the project progresses. Backend services may require additional configuration as they are introduced.

## Usage

The intended field-agent workflow is:

1. Open the application and access the field data collection workflow.  
2. Search for an existing farmer or household before creating a new record.  
3. Register or update the relevant farmer and household information.  
4. Record the agricultural field boundary and, where applicable, its access path.  
5. Review the collected geographic data and resolve any validation issues.  
6. Save the record locally.  
7. Synchronize collected records with the central backend when an internet connection is available.

The application is being designed to retain locally collected data until the server confirms successful receipt.

## Project Structure

The repository's structure will evolve as development progresses. The main areas of the project are expected to include:

| Directory | Purpose |
| :---- | :---- |
| app/ | Flutter application (Android) |
| app/lib/ | Application source code |
| app/test/ | Automated tests |
| docs/ | Project documentation and technical design |
| .github/workflows/ | CI workflows |
| .github/actions/ | Shared CI setup steps |
| .run/ | Shared Android Studio run configuration |

Data and Security

Because the application handles potentially sensitive farmer and household information, data protection is an important design consideration.

Planned security measures include:

- Encrypted local database storage.  
- Secure storage of encryption keys using platform-provided facilities.  
- Encrypted attachment storage.  
- HTTPS communication with backend services.  
- Role- and geographic-zone-based access controls.  
- Record versioning and conflict handling during synchronization.

**Development and testing must use synthetic data only. Do not commit real farmer information, photographs, credentials, API keys, or other sensitive information to this repository.**

## Development and Testing

The project uses GitHub Actions for continuous integration. Every pull request into `main` runs:

- Formatting and static analysis (`dart format`, `flutter analyze`).  
- Unit and widget tests.  
- A debug Android APK build, downloadable from the run's summary page.  
- A dependency license check. Only MIT, BSD-2-Clause, BSD-3-Clause, Apache-2.0, ISC and Zlib are allowed, so check a package's license before adding it.  
- A secret scan of the full git history.

Dependabot opens weekly pull requests for package and GitHub Actions updates.

Run the same checks locally from `app/`:

```sh
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Contributing

This project is being developed collaboratively as part of a university capstone project.

When contributing:

1. Check existing issues and project documentation before starting work.  
2. Coordinate changes that affect shared interfaces, data models, or synchronization contracts with the team.  
3. Keep changes focused and include tests where appropriate.  
4. Ensure `dart format`, `flutter analyze` and `flutter test` pass before submitting a pull request.  
5. Describe the purpose and impact of your changes in the pull request.

For significant architectural changes, consult the team before implementation and document the resulting decisions.

## Project Status

*In active development.*

The initial development work focuses on establishing the Flutter application structure, development workflows, and core offline data collection functionality.

Features, dependencies, and implementation details are subject to change as requirements are refined with the project partner.

## Acknowledgments

Developed by an Oregon State University CS461 capstone team in collaboration with the **Virunga Foundation**.

The project supports the Foundation's agricultural traceability and field data collection efforts.

## License

A project license has not yet been selected. Licensing information will be added once it has been determined.

&nbsp;