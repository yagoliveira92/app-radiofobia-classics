import 'package:app_radiofobia_classics/app/utils/social_enum.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  final List<SocialEnum> socialMediaLinks = SocialEnum.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B4B4B),
        title: const Text('Contato'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Entre em contato conosco!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff3F3D40),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Siga-nos nas redes sociais:',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xff3F3D40),
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: socialMediaLinks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                iconColor: const Color(0xff3F3D40),
                trailing: const Icon(Icons.chevron_right),
                leading: Icon(socialMediaLinks[index].icon),
                title: Text(socialMediaLinks[index].name),
                onTap: () => launchUrl(
                  Uri.parse(socialMediaLinks[index].url),
                  mode: LaunchMode.externalApplication,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        ],
      ),
    );
  }
}
