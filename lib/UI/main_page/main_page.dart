import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/dish_edit_page/dish_edit_page.dart';
import 'package:integral_admin/UI/main_page/widgets/categories.dart';
import 'package:integral_admin/UI/main_page/widgets/dish_tile.dart';
import 'package:integral_admin/UI/main_page/widgets/market_title.dart';
import 'package:integral_admin/UI/main_page/widgets/search.dart';
import 'package:integral_admin/UI/routes/orders_page_route.dart';
import 'package:integral_admin/blocs/main_page_bloc/mainpage_bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/services/responsive_size.dart';

class MainPage extends StatelessWidget {
  final TextEditingController search = TextEditingController();

  void unfocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    var mainBloc = BlocProvider.of<MainPageBloc>(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => unfocus(context),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var status = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishEditScreen<DishCreate>.create(),
                ),
              );
              if (status) {
                mainBloc.add(Update());
              }
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
                  Navigator.push(
                    context,
                    OrdersPageRoute(),
                  );
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
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: RefreshIndicator(
            onRefresh: () async {
              mainBloc.add(Update());
            },
            child: BlocBuilder<MainPageBloc, MainPageState>(
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
                              pinned: true,
                              centerTitle: true,
                              collapsedHeight: ResponsiveSize.height(115),
                              expandedHeight: ResponsiveSize.height(115),
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              flexibleSpace: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Search(
                                    controller: search,
                                    onEditingComplete: () {
                                      mainBloc.add(SearchEvent(search.text));
                                    },
                                  ),
                                  SizedBox(height: ResponsiveSize.height(24)),
                                  Categories(
                                    categories: Category.values,
                                    selectedCategory: state.category,
                                    onSelect: (category) {
                                      mainBloc
                                          .add(ChangeCategoryEvent(category));
                                    },
                                  ),
                                  SizedBox(height: ResponsiveSize.height(26)),
                                ],
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                  dishesCards(state.dishes!)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (state is LoadingState) {
                  return Loader();
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text('Загружаем данные...')
        ],
      ),
    );
  }
}
