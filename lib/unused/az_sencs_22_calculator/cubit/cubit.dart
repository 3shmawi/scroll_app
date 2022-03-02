import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/unused/az_sencs_22_calculator/cubit/states.dart';

class CalculatorCubit extends Cubit<CalculateStates> {
  CalculatorCubit() : super(CalculateInitialState());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  String input = '';

  void changeInput(String string) {
    input += string;
    emit(CalculateChangeInputState());
  }

  void lastInput(String string) {
    input = string;
    equalPressed();
    emit(CalculateLastInputState());
  }

  void removeLastInput() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
      emit(RemoveLastInputState());
    }
  }

  void removeAllInput() {
    input = '';
    result = 0.0;
    error = false;
    emit(RemoveAllInputState());
  }

  double result = 0.0;
  String textError = '';
  String firstSupString = '';
  String lastSupString = '';
  bool error = false;

  void equalPressed() {
    result = 0.0;
    //allOperations(input);

    if ((input.startsWith('.') ||
            input.startsWith('0') ||
            input.startsWith('1') ||
            input.startsWith('2') ||
            input.startsWith('3') ||
            input.startsWith('4') ||
            input.startsWith('5') ||
            input.startsWith('6') ||
            input.startsWith('7') ||
            input.startsWith('8') ||
            input.startsWith('9')) &&
        (input.endsWith('0') ||
            input.endsWith('1') ||
            input.endsWith('2') ||
            input.endsWith('3') ||
            input.endsWith('4') ||
            input.endsWith('5') ||
            input.endsWith('6') ||
            input.endsWith('7') ||
            input.endsWith('8') ||
            input.endsWith('9'))) {
      String char = '';
      int counter = 0;

      for (int i = 0; i < input.length; i++) {
        if (input[i] == '+' ||
            input[i] == '-' ||
            input[i] == 'x' ||
            input[i] == '÷' ||
            input[i] == '%') {
          char = input[i];
          counter = i;
          result += double.parse(input.substring(0, i));
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>$result');
          break;
        } else if (i == input.length - 1) {
          result = double.parse(input);
        }
      }
      const Duration(seconds: 3);
      for (int i = counter + 1; i < input.length; i++) {
        if (input[i] == '+') {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, i));
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, i));
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, i));
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, i));
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, i));
          }
          counter = i;
          char = '+';
        } else if (input[i] == '-') {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, i));
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, i));
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, i));
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, i));
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, i));
          }
          counter = i;
          char = '-';
        } else if (input[i] == 'x') {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, i));
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, i));
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, i));
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, i));
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, i));
          }
          counter = i;
          char = 'x';
        } else if (input[i] == '/') {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, i));
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, i));
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, i));
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, i));
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, i));
          }
          counter = i;
          char = '/';
        } else if (input[i] == '%') {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, i));
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, i));
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, i));
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, i));
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, i));
          }
          counter = i;
          char = '%';
        } else if (i == input.length - 1) {
          if (char == '+') {
            result += double.parse(input.substring(counter + 1, input.length));
            i = input.length;
            error = false;
          } else if (char == '-') {
            result -= double.parse(input.substring(counter + 1, input.length));
            i = input.length;
            error = false;
          } else if (char == 'x') {
            result *= double.parse(input.substring(counter + 1, input.length));
            i = input.length;
            error = false;
          } else if (char == '÷') {
            result /= double.parse(input.substring(counter + 1, input.length));
            i = input.length;
            error = false;
          } else if (char == '%') {
            result %= double.parse(input.substring(counter + 1, input.length));
            i = input.length;
            error = false;
          }
        }

        print("result is =>>>>>>>>>>>>>>>>$result");
      }
    } else {
      error = true;
      textError = 'Malformed expression';
    }
    allOperations(input.toString(), result.toString());
    emit(EqualButtonState());
  }

  List<String> list1 = [];
  List<String> list2 = [];

  void allOperations(input, result) {
    list1.add(input);
    list2.add(result);
    emit(MemoryState());
  }
}
