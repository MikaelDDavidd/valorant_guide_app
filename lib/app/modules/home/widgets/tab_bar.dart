import 'package:flutter/material.dart';

class TaskBar extends StatefulWidget {
  final List<Widget> gridCards;
  final List<Tab> tabs;

  TaskBar({
    required this.gridCards,
    required this.tabs,
  });

  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.gridCards.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabBar(
              labelStyle: const TextStyle(
                fontSize: 16,
                fontFamily: 'ProductSans',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              indicatorPadding: EdgeInsets.all(0.0),
              indicatorColor: Colors.blue, // Altere a cor indicadora conforme necessário
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.blue, // Altere a cor indicadora conforme necessário
                ),
                insets: EdgeInsets.symmetric(horizontal: 50.0),
              ),
              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              labelColor: Colors.blue, // Altere a cor do texto da aba selecionada conforme necessário
              unselectedLabelColor: Colors.grey, // Altere a cor do texto das abas não selecionadas conforme necessário
              tabs: widget.tabs,
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  _tabController.animateTo(index);
                });
              },
            ),
            IndexedStack(
              index: _selectedIndex,
              children: widget.gridCards,
            ),
          ],
        ),
      ),
    );
  }
}
