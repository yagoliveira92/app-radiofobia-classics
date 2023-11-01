import 'package:app_radiofobia_classics/app/utils/radio_app_icons.dart';
import 'package:flutter/material.dart';

enum SocialEnum {
  facebook(
      icon: RadioAppIcon.facebook_1,
      url: 'https://www.facebook.com/radiofobiaclassics/?locale=pt_BR',
      name: 'Facebook'),
  instagram(
      icon: RadioAppIcon.instagram_1,
      url: 'https://www.instagram.com/leoradiofobia/',
      name: 'Instagram'),

  youtube(
      icon: RadioAppIcon.youtube,
      url: 'https://youtube.com/radiofobia',
      name: 'YouTube'),

  email(
      icon: Icons.email_outlined,
      url: 'mailto:classics@radiofobia.com.br',
      name: 'Email'),
  whatsapp(
      icon: RadioAppIcon.telegram,
      url: 'https://t.me/radiofobianetwork',
      name: 'Grupo do Rádiofobia no Telegram');

  const SocialEnum({
    required this.icon,
    required this.url,
    required this.name,
  });

  final IconData icon;
  final String url;
  final String name;
}
