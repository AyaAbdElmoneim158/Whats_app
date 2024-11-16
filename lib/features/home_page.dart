import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/shared/widgets/custom_icon_button.dart';
import 'auth/presentation/view_model/auth_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Timer timer;

  updateUserPresence() {
    ref.read(authControllerProvider).updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(letterSpacing: 1),
          ),
          elevation: 1,
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ChatHomePage(),
            // StatusHomePage(),
            // CallHomePage(),
            Scaffold(
              body: Text(
                "ChatHomePage",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Scaffold(
              body: Text(
                "StatusHomePage",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Scaffold(
              body: Text(
                "CallHomePage",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
