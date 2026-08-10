import "package:url_launcher/url_launcher.dart";
export "package:url_launcher/url_launcher.dart";

/// Launches the [uri] if capabable
Future launchUri(
  Uri uri, [
  LaunchMode mode = LaunchMode.platformDefault,
]) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: mode);
  }
}
