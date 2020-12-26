import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/main_page/widgets/categories.dart';
import 'package:integral_admin/UI/main_page/widgets/dish_tile.dart';
import 'package:integral_admin/UI/main_page/widgets/market_title.dart';
import 'package:integral_admin/UI/main_page/widgets/search.dart';
import 'package:integral_admin/UI/orders_page/orders_page.dart';
import 'package:integral_admin/blocs/main_page_bloc/mainpage_bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class MainPage extends StatelessWidget {
  void unfocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => unfocus(context),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DishCreateScreen()));*/
              FormData formData = FormData.fromMap({
                'name': 'dish',
                'description': 'test description',
                'picture':
                    'https://www.forumdaily.com/wp-content/uploads/2016/08/Depositphotos_41466555_m-2015.jpg',
                'categories': [2, 3],
                'price': 100,
              });
              Response res = await Dio().post(
                  'http://178.154.255.209:3777/dishes/',
                  data: formData,
                  options: Options(contentType: Headers.jsonContentType));
              print(res);
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0.0,
            leading: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrdersPage()));
                },
                child: Container(
                    height: ResponsiveSize.height(40),
                    width: ResponsiveSize.width(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Icon(
                      Icons.description,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: BlocBuilder<MainPageBloc, MainPageState>(
            builder: (context, state) {
              if (state is MainPageInitialState) {
                return Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                MarketTitle(),
                              ],
                            ),
                          ),
                          SliverAppBar(
                            elevation: 0.0,
                            stretch: true,
                            collapsedHeight: ResponsiveSize.height(115),
                            expandedHeight: ResponsiveSize.height(115),
                            backgroundColor: Theme.of(context).backgroundColor,
                            flexibleSpace: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Search(),
                                SizedBox(height: ResponsiveSize.height(24)),
                                Categories(
                                  categories: Category.values,
                                  selectedCategory: state.category,
                                  onSelect: (category) {
                                    context
                                        .read<MainPageBloc>()
                                        .add(ChangeCategoryEvent(category));
                                  },
                                ),
                                SizedBox(height: ResponsiveSize.height(26)),
                              ],
                            ),
                            pinned: true,
                            centerTitle: true,
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                                dishesCards(state.dishes)),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              if (state is LoadingState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Loading data...')
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
