import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/bloc/personbloc/person_event.dart';
import 'package:flutter_movie/src/bloc/personbloc/person_state.dart';
import 'package:flutter_movie/src/model/person.dart';
import 'package:flutter_movie/src/service/api_service.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonEventStated) {
      yield* _mapMovieEventStartedToState();
    }
  }

  Stream<PersonState> _mapMovieEventStartedToState() async* {
    final apiRepository = ApiService();
    yield PersonLoading();
    try {
      print('Genrebloc called.');
      final List<Person> movies = await apiRepository.getTrendingPerson();
      yield PersonLoaded(movies);
    } catch (_) {
      yield PersonError();
    }
  }
}
