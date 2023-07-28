import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:notes/screens/editNote.dart';
import 'package:notes/services/NoteService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  final TextEditingController _filter = TextEditingController();
  String? id;
  String? catId;
  String _searchText = "";
  List names = [];
  List filteredNames = [];

  void _getNames() async {
    final response = await getIt<NoteService>().allTodos();
    List tempList = [];
    for (int i = 0; i < response.length; i++) {
      tempList.add(response[i]);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }

  Widget _buildList() {
    if ((_searchText.isNotEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['title']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: names.isEmpty ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: Colors.grey[400],
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    id = filteredNames[index]['id'].toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNote(
                          id: id,
                          title: filteredNames[index]['title'],
                          description: filteredNames[index]['description'],
                        ),
                      ),
                    );
                  },
                  subtitle: Text(
                    filteredNames[index]['description'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  title: Text(filteredNames[index]['title']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Search",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: AnimSearchBar(
                autoFocus: true,
                onSubmitted: (p0) {},
                helpText: 'Search Notes...',
                // closeSearchOnSuffixTap: true,
                color: Colors.grey[400],
                rtl: true,
                width: 400,
                textController: _filter,
                onSuffixTap: () {
                  setState(
                    () {
                      _filter.clear();
                    },
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'All Notes',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: _buildList(),
            )
          ],
        ),
      ),
    );
  }
}
