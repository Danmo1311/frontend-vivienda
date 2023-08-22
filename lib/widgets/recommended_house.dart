import 'package:flutter/material.dart';

import 'package:house_rent/models/house.dart';
import 'package:house_rent/screens/details/details.dart';
import 'package:house_rent/widgets/circle_icon_button.dart';

class RecommendedHouse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<House>>(
      future: House.generateRecommended(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<House> recommendedList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 340,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () =>
                        _handleNavigateToDetails(context, recommendedList[index]),
                    child: Container(
                      height: 300,
                      width: 230,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  recommendedList[index].imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15,
                            top: 15,
                            child: CircleIconButton(
                              iconUrl: 'assets/icons/mark.svg',
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.white54,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recommendedList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        recommendedList[index].address,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleIconButton(
                                    iconUrl: 'assets/icons/mark.svg',
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (_, index) => const SizedBox(width: 20),
                  itemCount: recommendedList.length,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        }
        return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se espera la respuesta.
      },
    );
  }

  void _handleNavigateToDetails(BuildContext context, House house) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Details(house: house),
      ),
    );
  }
}
