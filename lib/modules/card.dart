import 'package:flutter/material.dart';
import 'package:store_app/helper/db_helper.dart';
import 'package:store_app/layout/home_layout.dart';
import 'package:store_app/models/db_models/cards.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<String> categories = [
    'playstation 5',
    'Shoes size large',
    'te-shirt size x-large',
    'playstation 5',
    'playstation 5',
  ];
  List<String> categoryImages = [
    'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
  ];
  DbHelper? helper;
  Map<int,int> map = {};
  late int counter;
  double sumOfPrice = 0;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper!.readAllCard().then((value) {
      value.forEach((m) {
        sumOfPrice = sumOfPrice + m['price'];
      });
      value.forEach((e) {
        setState(() {
          map.addAll({
            e['id']:1,
          });
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
            future: helper!.readAllCard(),
            builder: (context,AsyncSnapshot? snapshot) {
              if(snapshot!.hasData&&map!={}) {
                return Column(
                  children: [
                    ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        CardsModel cardsModel = CardsModel.fromJson(snapshot.data[index]);
                        return Dismissible(
                          key: ValueKey(cardsModel),
                          onDismissed: (direction) {
                            helper!.deleteFromCard(cardsModel.id!);
                            sumOfPrice = sumOfPrice - (map[cardsModel.id]! * cardsModel.price!);
                          },
                          child: Container(
                            height: 100,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  child: Image(
                                    image: NetworkImage(
                                      '${cardsModel.image}',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cardsModel.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$ ${cardsModel.price}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      counter = map[cardsModel.id]!;
                                      if(counter!=1) {
                                        counter--;
                                        map[cardsModel.id!]=counter;
                                        sumOfPrice = sumOfPrice - cardsModel.price!;
                                      }
                                    });
                                  },
                                  icon:const Icon(
                                    Icons.remove,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '${map[cardsModel.id]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      counter = map[cardsModel.id]!;
                                      if(counter!=20) {
                                        counter++;
                                        map[cardsModel.id!]=counter;
                                        sumOfPrice = sumOfPrice + cardsModel.price!;
                                      }
                                    });
                                  },
                                  icon:const Icon(
                                    Icons.add,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 3.5,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Order Info',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children:[
                        const Expanded(
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          sumOfPrice==0?'\$ 00:00':'\$ 25.00',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          sumOfPrice==0?'\$ 00:00':'\$ ${(sumOfPrice+25).toStringAsFixed(2)}',
                          style:const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 280,
                        padding: const EdgeInsetsDirectional.only(
                          top: 13,
                          bottom: 13,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              18,
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }else {
                return const Center(child: CircularProgressIndicator(color: Colors.red,));
              }
            },
          ),
        ),
      ),
    );
  }
}
