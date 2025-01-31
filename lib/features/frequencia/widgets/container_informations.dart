import 'package:flutter/material.dart';
import 'package:flutter_app/features/frequencia/provider/frequencia_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/core/app_export.dart';

class ContainerInformations extends StatelessWidget {
  final Function(BuildContext) selectDate;
  ContainerInformations({
    super.key,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    final frequenciaProvider = Provider.of<FrequenciaProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.07,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Mês selecionado: ${frequenciaProvider.mes}',
                      style: CustomTextStyle.fontInfoAlunoWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () async {
                DateTime data = await selectDate(
                  context,
                );
                // await frequenciaProvider.selectDateProvider(data);
                debugPrint('data mes: $data');
              },
              icon: const Icon(
                size: 35,
                Icons.calendar_month,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
