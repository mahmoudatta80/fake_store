import 'package:flutter/material.dart';
import 'package:store_app/helper/db_helper.dart';
import 'package:store_app/helper/dio_helper.dart';
import 'package:store_app/models/db_models/cards.dart';
import 'package:store_app/models/dio_models/single_product.dart';

class DetailsScreen extends StatefulWidget {
  late int id;
  DetailsScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  SingleProductModel? singleProductModel;
  List listOfCards = [];
  DbHelper? helper;
  bool testIsCard = false;
  bool isComplete = false;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    DioHelper.getSingleProduct(widget.id).then((value) {
      singleProductModel = SingleProductModel.fromJson(value.data);
    }).then((value) {
      helper!.readAllCard().then((value) {
        listOfCards = value;
      }).then((value) {
        listOfCards.forEach((e) {
          if(e['id']==singleProductModel!.id) {
            testIsCard = true;
          }
        });
        isComplete = true;
        setState(() {});
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future: DioHelper.getSingleProduct(widget.id),
            builder: (context,AsyncSnapshot? snapshot) {
              if(isComplete&&singleProductModel!=null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Image(
                        image: NetworkImage(
                          '${singleProductModel!.image}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${singleProductModel!.title}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$ ${singleProductModel!.price}',
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Description',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${singleProductModel!.description}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: testIsCard?InkWell(
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
                              'Added to card',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ):InkWell(
                        onTap: () {
                          CardsModel cardsModel = CardsModel({
                            'id': singleProductModel!.id,
                            'title': singleProductModel!.title,
                            'image': singleProductModel!.image,
                            'price': singleProductModel!.price,
                          });
                          helper!.insertToCard(cardsModel);
                          testIsCard = true;
                          setState(() {});
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
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:const [
                                Text(
                                  'Add to card',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.red,
                                ),
                              ],
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
