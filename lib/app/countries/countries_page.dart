import 'package:flutter_firebase_phone_auth_riverpod/global_providers.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CountriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Country / Region"),
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final authService = context.read(authServiceProvider);
          return ListView.builder(
            itemCount: authService.countries.length,
            itemBuilder: (BuildContext context, int index) {
              final country = authService.countries[index];
              final isSelected =
                  (authService.countryCode == country.countryCode);
              return Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.grey[200],
                ),
                child: _countryListTile(
                  context: context,
                  country: country,
                  isSelected: isSelected,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _countryListTile({
    BuildContext context,
    @required CountryWithPhoneCode country,
    isSelected = false,
  }) {
    return ListTile(
      dense: true,
      title: Row(
        children: <Widget>[
          Text(
            '${_flag(country.countryCode)}',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(width: 10),
          Text(
            '${country.countryName}',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16.0, letterSpacing: -0.2, color: Colors.black),
          ),
          SizedBox(width: 5),
          Text(
            '(+${country.phoneCode})',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16.0, letterSpacing: -0.2, color: Colors.grey),
          ),
        ],
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: Colors.blueAccent)
          : SizedBox.shrink(),
      onTap: () {
        final authService = context.read(authServiceProvider);
        authService.setCountry(country);
        Navigator.pop(context);
      },
    );
  }

  String _flag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
  }
}
