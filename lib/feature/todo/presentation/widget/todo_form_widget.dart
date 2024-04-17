import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/common_widget/custom_button_widget.dart';
import 'package:todo_app/core/common_widget/custom_text_field.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_utils.dart';
import 'package:todo_app/core/utils/dimens.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_cubit.dart';

class TodoFormWidget extends StatefulWidget {
  const TodoFormWidget({super.key});

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final GlobalKey<FormState> _todoFormKey = GlobalKey<FormState>();
  final TextEditingController _todoTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _todoFormKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(18.0 * Utils.getScalingFactor(context)),
              child: CustomTextFormField(
                hintText: "Please Enter todos value",
                textInputType: TextInputType.text,
                validator: (value) => Utils.validate(value, field: "todo"),
                autofocus: false,
                textStyle: TextStyle(
                    fontSize: fontBodyTextLarge, color: AppColors.black50),
                hintStyle: TextStyle(
                    fontSize: fontBodyTextMedium, color: AppColors.black50),
                controller: _todoTextEditingController,
              ),
            ),
            SizedBox(height: sizeX10 * Utils.getScalingFactor(context)),
            CustomButton(
              height: sizeX50 * Utils.getScalingFactor(context),
              width: sizeX250 * Utils.getScalingFactor(context),
              text: "Submit",
              onPressed: () {
                if (_todoFormKey.currentState!.validate()) {
                  context.read<TodoCubit>().addTodos(
                        _todoTextEditingController.text,
                        true,
                      );
                  Navigator.pop(context);
                }
              },
              buttonStyle: CustomButtonStyles.fillBlueGray.copyWith(
                backgroundColor: MaterialStatePropertyAll(AppColors.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
