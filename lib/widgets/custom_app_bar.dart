import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  Future<String> fetchUserPhoto() async {
    // Usando CORS Anywhere como proxy para evitar restricciones de CORS durante el desarrollo
    final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/https://f6c0-181-143-170-114.ngrok-free.app/users/64a994b32e9ab9c5bc3addf3'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['photo'];
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/menu.svg'),
            ),
            FutureBuilder<String>(
              future: fetchUserPhoto(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(snapshot.data!),
                    );
                  } else {
                    return CircleAvatar(
                      child: Icon(Icons.error),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
