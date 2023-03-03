import 'package:flutter/material.dart';
import 'package:store_app/helper/db_helper.dart';
import 'package:store_app/helper/dio_helper.dart';
import 'package:store_app/layout/home_layout.dart';
import 'package:store_app/models/db_models/cards.dart';
import 'package:store_app/models/db_models/favourites.dart';
import 'package:store_app/models/dio_models/categories.dart';
import 'package:store_app/modules/details.dart';

class SingleCategoryScreen extends StatefulWidget {
  String? category;
  bool? isHome;

  SingleCategoryScreen({Key? key, this.category, this.isHome})
      : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {

  List<CategoriesModel> categoryModel = [];
  List listOfCard = [];
  List listOfFavourites = [];
  DbHelper? helper;
  bool testIsCard = true;
  bool checkComplete = false;
  Map<int, bool> favourites = {};

  @override
  void initState() {
    super.initState();
    checkComplete = false;
    setState(() {});
    DioHelper.getSingleCategory(widget.category!).then((value) {
      value.data.forEach((e) {
        setState(() {
          categoryModel.add(CategoriesModel.fromJson(e));
        });
      });
    }).then((value) {
      categoryModel.forEach((e) {
        favourites.addAll({
          e.id!: false,
        });
      });
    }).then((value) {
      helper!.readAllFavourites().then((value) {
        listOfFavourites = value;
        categoryModel.forEach((e) {
          favourites.addAll({
            e.id!: false,
          });
        });
      }).then((value) {
        listOfFavourites.forEach((e) {
          categoryModel.forEach((m) {
            if (e['id'] == m.id) {
              favourites[m.id!] = true;
            }
          });
        });
        checkComplete = true;
        setState(() {});
      });
    });
    helper = DbHelper();
    helper!.readAllCard().then((value) {
      listOfCard = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.isHome!
            ? Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomeLayout(),
                ),
                (route) => false)
            : Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: Colors.black87,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black45,
                            ),
                            suffixIcon: Icon(
                              Icons.mic,
                              color: Colors.black45,
                            ),
                            focusColor: Colors.black87,
                            fillColor: Colors.black87,
                            hoverColor: Colors.black87,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.double_arrow_outlined,
                        color: Colors.red,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: DioHelper.getSingleCategory(widget.category!),
                    builder: (context, snapshot) {
                      if (categoryModel.isNotEmpty && favourites != {}) {
                        return checkComplete
                            ? GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount: categoryModel.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 8,
                                    end: 8,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreen(id: categoryModel[index].id!),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: double.infinity,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15,
                                                ),
                                              ),
                                              child: Image(
                                                image: NetworkImage(
                                                  '${categoryModel[index].image}',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.grey,
                                                child: IconButton(
                                                  onPressed: () {
                                                    FavouritesModel
                                                        favouritesModel =
                                                        FavouritesModel({
                                                      'id': categoryModel[index]
                                                          .id,
                                                      'title':
                                                          categoryModel[index]
                                                              .title,
                                                      'image':
                                                          categoryModel[index]
                                                              .image,
                                                      'price':
                                                          categoryModel[index]
                                                              .price,
                                                    });
                                                    favourites[
                                                            categoryModel[index]
                                                                .id!]!
                                                        ? setState(() {
                                                            favourites[
                                                                categoryModel[
                                                                        index]
                                                                    .id!] = false;
                                                            helper!.deleteFromFavourites(
                                                                categoryModel[
                                                                        index]
                                                                    .id!);
                                                          })
                                                        : setState(() {
                                                            favourites[
                                                                categoryModel[
                                                                        index]
                                                                    .id!] = true;
                                                            helper!.insertToFavourites(
                                                                favouritesModel);
                                                          });
                                                  },
                                                  icon: favourites[
                                                          categoryModel[index]
                                                              .id]!
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                          size: 20,
                                                        )
                                                      : const Icon(
                                                          Icons.favorite,
                                                          color: Colors.black,
                                                          size: 20,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${categoryModel[index].title}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '\$ ${categoryModel[index].price}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                CardsModel cardsModel =
                                                CardsModel({
                                                  'id': categoryModel[index].id,
                                                  'title': categoryModel[index].title,
                                                  'image': categoryModel[index].image,
                                                  'price': categoryModel[index].price,
                                                });
                                                listOfCard.forEach((e) {
                                                  if (e['id'] ==
                                                      categoryModel[index].id) {
                                                    setState(() {
                                                      testIsCard = false;
                                                    });
                                                  }
                                                });
                                                testIsCard
                                                    ? helper!.insertToCard(
                                                        cardsModel)
                                                    : null;
                                                setState(() {
                                                  testIsCard = true;
                                                });
                                              },
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.red,
                              ));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
