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

                  SizedBox(
                    width: 110,
                    child: CustomTextField2(
                      title: 'Manager\'s mobile',
                      controller: TextEditingController(text: '+256'),
                      enabled: false,
                    ),
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
