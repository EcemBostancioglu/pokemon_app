
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/app_colors.dart';
import 'package:pokemon/presentation/details_bloc/details_bloc.dart';
import 'package:pokemon/widgets/box.dart';

class FeaturesCard extends StatefulWidget {
  FeaturesCard({
    required this.name,
    required this.pokemon,
    Key? key,
  }) : super(key: key);

  final String name;
  final String pokemon;

  @override
  State<FeaturesCard> createState() => _FeaturesCardState();
}

class _FeaturesCardState extends State<FeaturesCard> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:400.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(28.r),
              topLeft: Radius.circular(28.r))),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Text(widget.name, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.sp, color: blue)),
            ),
          ), //NAME
        Expanded(
          flex:4,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) {
                  if (state is CharacterFeaturesState) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.abilities.length,
                        itemBuilder: (context, index) {
                          var data = state.abilities.toList();
                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: blueShade100,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.r)),
                                ),
                                child: Center(
                                    child: Text(
                                        data[index].ability!.name.toString(),
                                        textAlign: TextAlign.center))),
                          );
                        }
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator());
                },
              ),
            ), //ABILITIES
            SizedBox(
              height: 40.h,
              child: BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) {
                  if (state is CharacterFeaturesState) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.types.length,
                        itemBuilder: (context, index) {
                          var data = state.types.toList();
                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: yellow,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.r)),
                                ),
                                child: Center(
                                    child: Text(
                                        data[index].type!.name.toString(),
                                        textAlign: TextAlign.center))),
                          );
                        }
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator());
                },
              ),
            ), //Types
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is CharacterFeaturesState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Box(state: state,feature: 'Weight',unit:'Kg',index: 0),
                      Box(state: state,feature: 'Height',unit:'M',index: 1)
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            )
          ],
      ),
        )
        ],
      ),
    );
  }
}

