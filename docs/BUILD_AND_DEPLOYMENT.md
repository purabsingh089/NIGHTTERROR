# Build and deployment

## Local Godot project

The project targets Godot 4.3 as declared in `project.godot` and the GitHub workflow. Open the repository in Godot and run the configured main scene, `scenes/main.tscn`. No dependency manifest or separate game-code library installation is present.

## Android presets

`export_presets.cfg` defines debug/test APK presets named `Android ARMv7` and `Android ARM64`, with output paths under `build/`. Both use package identifier `com.nightterror.game`, version `0.1.0`, and portrait orientation; each preset enables its matching ABI. Exports require Godot 4.3 Android templates and Android/JDK tooling.

## GitHub Actions

`.github/workflows/build-apks.yml` is the authoritative workflow:

- Push to `main`: checkout, Godot 4.3 project parse, headless startup and first-frame markers. No APK export or upload.
- Manual `workflow_dispatch`: run the same validation first; then install Godot templates, JDK 17, Android SDK platform-tools/build-tools 34 and platform 34; generate an ephemeral debug keystore; export both APKs; validate archive integrity, signature, package/version, SDK metadata and expected ABI; produce SHA-256 sums; upload the two APKs and checksum as a 14-day Actions artifact.
- There is no GitHub Release or external publishing step.

The debug key is transient and regenerated on future runs; installing a new build over one signed by another key may require uninstalling the prior app, which can remove local app data. Actions artifacts follow repository access permissions and expire after the configured retention.

## Evidence and device deployment

The latest documented manual validation is run `44749704663` on `c6133ec`; both APKs passed CI structure/signature/metadata/ABI checks. This does not establish successful installation or runtime behavior on the affected phone. Prior user reports of archive extraction/package parse errors and a black screen are unresolved; see [known issues](KNOWN_ISSUES.md).
