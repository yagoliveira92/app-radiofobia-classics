import 'package:app_radiofobia_classics/app/utils/radio_app_icons.dart';
import 'package:flutter/cupertino.dart';

enum SocialEnum {
  facebook(
      icon: RadioAppIcon.facebook_1,
      url: 'https://www.facebook.com/radiofobiapodcast/?locale=pt_BR',
      name: 'Facebook'),
  instagram(
      icon: RadioAppIcon.instagram_1,
      url: 'https://www.instagram.com/radiofobiapodcast/',
      name: 'Instagram'),
  whatsapp(
      icon: RadioAppIcon.telegram,
      url: 'https://t.me/radiofobianetwork',
      name: 'Grupo do Radiofobia no Telegram');

  const SocialEnum({
    required this.icon,
    required this.url,
    required this.name,
  });

  final IconData icon;
  final String url;
  final String name;
}
