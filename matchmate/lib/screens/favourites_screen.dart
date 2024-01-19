import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar1.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/components/search_bar.dart';
import 'package:matchmate/screens/favourites.dart';
import 'package:matchmate/screens/requests.dart';
import 'package:matchmate/screens/pending_requests.dart';

class FavouritesScreen extends StatefulWidget {
  static String id = 'favourites_screen';
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 10,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicatorColor: kColor4,
                tabs: [
                  Tab(
                    child: Text(
                      'Favourites',
                      style: tabBartextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Requests',
                      style: tabBartextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Pendings',
                      style: tabBartextStyle,
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.25),
                      BlendMode.dstATop,
                    ),
                    child: Image.asset('assets/logo.jpg'),
                  ),
                ),
              ),
              TabBarView(children: [
                Container(
                  child: Favourites(),
                ),
                Container(
                  child: Requests(),
                ),
                Container(
                  child: Pending(),
                )
              ]),
            ]),
          )),
    );
  }
}
