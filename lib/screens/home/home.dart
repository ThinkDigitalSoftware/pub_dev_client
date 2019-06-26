import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:pub_client/pub_client.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pub_dev_client/widgets/default_pacakges_list.dart';
import 'package:pub_dev_client/widgets/pub_header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PubClient _client = PubClient();
  PubHtmlParsingClient _htmlParsingClient = PubHtmlParsingClient();
  Page firstPage;
  int FIRST_PAGE = 1;
  List<FullPackage> packagesFromPage = [];
  DateFormat _dateFormat = DateFormat("MMM d, yyyy");
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Takes a Page of Packages and gets the FullPackage
  /// equivalents of each Package
  void convertToFullPackagesFromPage(Page page) async {
    for (int i = 0; i < page.packages.length; i++) {
      String packageName = page.packages[i].name;
      try {
        FullPackage _fullPackage = await _htmlParsingClient.get(packageName);
        packagesFromPage.add(_fullPackage);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            //Get under the status bar without losing dark color
            Container(
              color: PubColors().darkColor,
              height: 16,
            ),
            Container(
              color: PubColors().darkColor,
              child: ListTile(
                leading: Icon(GroovinMaterialIcons.dart_logo, color: Colors.blue,),
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
                      fontSize: 22,
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
                  onTap: () {}, //TODO: launch https://flutter.dev/docs/development/packages-and-plugins/using-packages
                ),
                ListTile(
                  title: Text('Developing Packages and Plugins'),
                  trailing: Icon(Icons.launch),
                  onTap: () {}, //TODO: launch https://flutter.dev/docs/development/packages-and-plugins/developing-packages
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
                  onTap: () {}, //TODO: launch https://dart.dev/tools/pub/publishing
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
                      fontSize: 22,
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
              title: Text('Version 0.1.0'), //TODO: dynamically show version number based on build.gradle using package_info plugin
              subtitle: Text('Authored by ThinkDigitalRepair and GroovinChip'),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Page>(
        future: _client.getPageOfPackages(1),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final page = snapshot.data;
            //convertToFullPackagesFromPage(page);
            //print(packagesFromPage.length);
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: PubHeader(),
                  ),
                ];
              },
              body: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return MockPackageTile();
                },
              ),
              /*body: DefaultPackagesList(
                packagesFromPage: packagesFromPage,
              ),*/
            );
          }
        },
      ),
    );
  }
}


class MockPackageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroovinExpansionTile(
      title: Text(
        'mock_package',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "v " +
            '1' +
            '.' +
            '0' +
            '.' +
            '0' +
            ' updated ' +
            'June 26, 2019',
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Text('This is a package description for a mock package'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Row(
            //TODO: extract tags into their own widgets
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: 30,
                  width: 86,
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(GroovinMaterialIcons.tag, size: 16, color: Colors.black38,),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Flutter', style: TextStyle(color: Colors.black38),),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: 30,
                  width: 80,
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(GroovinMaterialIcons.tag, size: 16, color: Colors.black38,),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Web', style: TextStyle(color: Colors.black38),),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  height: 30,
                  width: 72,
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(GroovinMaterialIcons.tag, size: 16, color: Colors.black38,),
                        SizedBox(
                          width: 6,
                        ),
                        Text('All', style: TextStyle(color: Colors.black38),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      trailing: CircleAvatar(
        child: Text('100'),
      ),
    );
  }
}

//TODO: pass this class down from above MaterialApp with Provider
class PubColors {
  Color darkColor = Color.fromRGBO(18, 32, 48, 1);
}