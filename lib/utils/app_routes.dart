import 'package:calculater_app/view/add_contact_screen.dart';
import 'package:calculater_app/view/contact_screen.dart';
import 'package:calculater_app/view/hide_contact.dart';
import 'package:calculater_app/view/intro_screen.dart';
import 'package:calculater_app/view/splesh_screen.dart';
import 'package:calculater_app/view/contact_info.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (Context) => const SpleshScreen(),
  'intro': (Context) => const IntroScreen(),
  'contact': (Context) => const ContactScreen(),
  'addContact': (Context) => const AddContactScreen(),
  'update': (Context) => const ContactInfoScreen(),
  'hideContact': (Context) => const HideContactScreen(),
};
