import 'package:url_launcher/url_launcher.dart';
import 'package:gloss_bloom/core/constants/app_constants.dart';

class UrlLauncherHelper {
  static Future<bool> launchWhatsApp(String phoneNumber, [String? message]) async {
    final Uri uri;
    if (message != null && message.isNotEmpty) {
      uri = Uri.parse('${AppConstants.whatsappBaseUrl}/$phoneNumber?text=${Uri.encodeComponent(message)}');
    } else {
      uri = Uri.parse('${AppConstants.whatsappBaseUrl}/$phoneNumber');
    }
    
    return await launchUrl(uri);
  }

  static Future<bool> launchEmail(String email, [String? subject, String? body]) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: _buildEmailQuery(subject, body),
    );
    
    return await launchUrl(uri);
  }

  static Future<bool> launchUrlString(String url) async {
    final Uri uri = Uri.parse(url);
    return await launchUrl(uri);
  }

  static String _buildEmailQuery(String? subject, String? body) {
    final params = <String>[];
    if (subject != null) params.add('subject=${Uri.encodeComponent(subject)}');
    if (body != null) params.add('body=${Uri.encodeComponent(body)}');
    return params.join('&');
  }
}