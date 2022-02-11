import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchContoller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchContoller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchContoller,
          decoration: const InputDecoration(hintText: 'Search for a user'),
          onFieldSubmitted: (String val) {
            print('Value: $val');
          },
        ),
      ),
    );
  }
}
