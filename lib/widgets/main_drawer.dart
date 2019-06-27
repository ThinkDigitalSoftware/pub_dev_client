import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          //Get under the status bar without losing dark color
          Container(
            color: PubColors().darkColor,
            height: 16,
          ),
          Container(
            color: PubColors().darkColor,
            child: ListTile(
              leading: Icon(
                GroovinMaterialIcons.dart_logo,
                color: Colors.blue,
              ),
              title: Text(
                'pub.dev',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Getting Started:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          GroovinExpansionTile(
            title: Text(
              'Flutter:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            children: <Widget>[
              ListTile(
                title: Text('Using Packages'),
                trailing: Icon(Icons.launch),
                onTap:
                    () {}, //TODO: launch https://flutter.dev/docs/development/packages-and-plugins/using-packages
              ),
              ListTile(
                title: Text('Developing Packages and Plugins'),
                trailing: Icon(Icons.launch),
                onTap:
                    () {}, //TODO: launch https://flutter.dev/docs/development/packages-and-plugins/developing-packages
              ),
            ],
          ),
          GroovinExpansionTile(
            title: Text(
              'Web and Server:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            children: <Widget>[
              ListTile(
                title: Text('Using Packages'),
                trailing: Icon(Icons.launch),
                onTap: () {}, //TODO: launch hhttps://dart.dev/guides/packages
              ),
              ListTile(
                title: Text('Publishing a Package'),
                trailing: Icon(Icons.launch),
                onTap:
                    () {}, //TODO: launch https://dart.dev/tools/pub/publishing
              ),
              ListTile(
                title: Text('Overview'),
                trailing: Icon(Icons.launch),
                onTap: () {}, //TODO: launch https://dart.dev/tools/pub/cmd
              ),
            ],
          ),
          Divider(
            color: PubColors().darkColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: Row(
              children: <Widget>[
                Text(
                  'Settings:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Toggle Dark Theme',
              style: TextStyle(
                fontSize: 18,
              ),
            ), //TODO: change text based on which theme is on
            trailing: Icon(Icons.brightness_3),
            onTap: () {}, //TODO: toggle theme via DynamicTheme package
          ),
          Expanded(child: Container()),
          Divider(
            color: PubColors().darkColor,
          ),
          ListTile(
            title: Text(
                'Version 0.1.0'), //TODO: dynamically show version number based on build.gradle using package_info plugin
            subtitle: Text('Authored by ThinkDigitalRepair and GroovinChip'),
          ),
        ],
      ),
    );
  }
}

//TODO: pass this class down from above MaterialApp with Provider
class PubColors {
  Color darkColor = Color.fromRGBO(18, 32, 48, 1);
}
