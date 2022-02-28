import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/social_links.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  final ContactUs _contactUs;

  ContactUsView(this._contactUs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contactUs.addressTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text(
              "Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(_contactUs.addressSummary),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(_contactUs.email),
            onTap: () async {
              if (await canLaunch("mailto:${_contactUs.email}")) {
                launch("mailto:${_contactUs.email}");
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              "Phone",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(_contactUs.phone),
            onTap: () async {
              if (await canLaunch("tel:${_contactUs.phone}")) {
                launch("tel:${_contactUs.phone}");
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text(
              "Fax",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(_contactUs.fax ?? "N/A"),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text(
              "View Google Map",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              if (await canLaunch(_contactUs.mapLink)) {
                launch(_contactUs.mapLink);
              }
            },
          ),
        ],
      ),
    );
  }
}
