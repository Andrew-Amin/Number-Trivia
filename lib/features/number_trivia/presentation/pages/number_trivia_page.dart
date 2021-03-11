import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: FutureBuilder(
        future: sl.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return buildBody(context);
          else
            return CircularProgressIndicator();
        },
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty)
                    return MessageDisplay(
                        message: 'Type number or search randomly...');
                  else if (state is Error)
                    return MessageDisplay(message: state.errorMessage);
                  else if (state is Loading)
                    return LoadingWidget();
                  else if (state is Loaded)
                    return TriviaDisplay(numberTrivia: state.numberTrivia);
                  return MessageDisplay(message: 'Unexpected erorr ~!!');
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
