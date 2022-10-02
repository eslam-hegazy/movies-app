import 'package:second_project/movies/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  RecommendationModel({
    required super.id,
    required super.backdrop_path,
  });
  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        id: json['id'],
        backdrop_path: json['backdrop_path'] ??
            "https://img.freepik.com/free-photo/studio-shot-cheerful-religious-muslim-woman-keeps-arms-folded-smiles-broadly-has-white-teeth_273609-27065.jpg?w=900&t=st=1664569224~exp=1664569824~hmac=c2f3a4c4c533cf1a764913d95b0841e6c07d89e766f61a8e3d724e5a51fcb618",
      );
}
