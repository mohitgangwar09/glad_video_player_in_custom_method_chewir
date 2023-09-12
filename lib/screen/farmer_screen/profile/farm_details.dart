import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class FarmDetails extends StatelessWidget {
  const FarmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileCubitState>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomTextField2(title: 'Farm Size',
                controller: state.farmSize,),
              20.verticalSpace(),
              CustomTextField2(title: 'Dairy Area',
                controller: state.dairyArea,),
              20.verticalSpace(),
              CustomTextField2(title: 'No. of people working in the farm',
                controller: state.staffQuantity,),
              20.verticalSpace(),
              CustomTextField2(title: 'Manager Name',
                controller: state.managerName,),
              20.verticalSpace(),
              Row(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(padding: const EdgeInsets.only(left: 3),
                        child: "Mobile No".textMedium(fontSize: 12),),

                      Container(
                        height: 60,
                        width: 95,
                        margin: const EdgeInsets.only(top: 3.5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffD9D9D9),width: 1.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            "+227".textMedium(
                                color:const Color(0xff727272)),

                            const Icon(Icons.keyboard_arrow_down),

                          ],
                        ),
                      ),
                    ],
                  ),

                  10.horizontalSpace(),

                  Expanded(
                    child: CustomTextField2(title: '',
                      controller: state.managerPhone,),
                  ),
                ],
              ),
              40.verticalSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: customButton(
                  'Save',
                  onTap: () async{
                    context.read<ProfileCubit>().updateFarmDetailApi(context);
                  },
                  radius: 40,
                  width: double.infinity,
                  height: 60,
                  style: figtreeMedium.copyWith(
                      color: Colors.white, fontSize: 16),
                ),
              ),
              20.verticalSpace(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: customButton('Cancel',
                    onTap: () {
                        pressBack();
                    },
                    radius: 40,
                    width: double.infinity,
                    height: 60,
                    style: figtreeMedium.copyWith(
                        color: Colors.black, fontSize: 16),
                    color: 0xFFDCDCDC),
              ),
            ],
          ),
        );
      },
    );
  }
}
