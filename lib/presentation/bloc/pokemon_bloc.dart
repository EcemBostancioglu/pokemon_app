import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/data/repository/abilities_client.dart';
import 'package:pokemon/data/repository/pokemon_client.dart';
import 'package:pokemon/domain/model/pokemon.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {

  PokemonClient pokemonRepository=PokemonClient();
  List<Pokemon>? pokemonNameList=[];

  AbilitiesClient abilitiesClient=AbilitiesClient();
  Iterable<Abilities>? abilities=[];

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonEvent>((event, emit) {});

    on<GetPokemonNameEvent>((event,emit)async{
      pokemonNameList=await pokemonRepository.getFetch();
      emit(GetPokemonNameState(pokemonList: pokemonNameList!));
    });

    on<CharacterFeaturesEvent>((event,emit)async{
      abilities=await abilitiesClient.getAbilities();
      emit(CharacterFeaturesState(abilities: abilities!));
    });

  }


}