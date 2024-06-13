import 'package:flutter/material.dart';

AppBar customAppBar({required TabController tabController}) {
  return AppBar(
    centerTitle: false,
    // backgroundColor: Colors.amber,
    title: const Text("Buscador Anuncio"),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: _tabBar(tabController: tabController),
    ),
  );
}

TabBar _tabBar({required TabController tabController}) {
  return TabBar(
    controller: tabController,
    tabs: [
      Tab(
        text: "Autos",
      ),
      Tab(
        text: "Inmuebles",
      ),
      Tab(
        text: "Electrónicos",
      ),
    ],
  );
}
