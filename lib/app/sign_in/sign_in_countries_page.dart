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
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final authService = ref.read(authServiceProvider);
          return ListView.separated(
            itemCount: authService.countries.length,
            separatorBuilder: (_, __) => Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Divider(
                color: Colors.grey[400],
                height: 0.5,
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              final country = authService.countries[index];
              return _countryListTile(context, ref, country);
            },
          );
        },
      ),
    );
  }

  Widget _countryListTile(
    BuildContext context,
    WidgetRef ref,
    CountryWithPhoneCode country,
  ) {
    return ListTile(
      dense: true,
      title: Text(
        '${country.countryName}',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      trailing: Text(
        '+${country.phoneCode}',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
      onTap: () {
        final authService = ref.read(authServiceProvider);
        authService.setCountry(country);
        Navigator.pop(context);
      },
    );
  }
}
