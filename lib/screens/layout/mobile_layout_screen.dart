import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuncchat/screens/auth/controller/auth_controller.dart';
import 'package:tuncchat/screens/screens.dart';
import 'package:tuncchat/utils/utils.dart';
import 'package:tuncchat/widgets/widgets.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  static const routeName = "/mobilelayout";
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: textColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          centerTitle: false,
          title: const Text(
            'TuncChat',
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.grey[900]!),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey[900]!),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.of(context)
                          .pushReplacementNamed(LandingScreen.routeName),
                    );
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: textColor,
            indicatorWeight: 4,
            labelColor: textColor,
            unselectedLabelColor: Colors.grey[900]!,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[900]!),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: const ContactsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SelectContactsScreen(),
              ),
            );
          },
          backgroundColor: textColor,
          child: const Icon(
            Icons.comment,
            color: backgroundColor,
          ),
        ),
      ),
    );
  }
}
