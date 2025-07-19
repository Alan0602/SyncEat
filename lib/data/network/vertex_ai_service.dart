import 'package:google_generative_ai/google_generative_ai.dart';

class VertexAIService {
  final GenerativeModel _model;

  VertexAIService()
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyBvvHIxLoFzvkirHPzXDbIsgSl81x5O1nU',
      );

  Future<String> getMealRecommendation(Map<String, dynamic> userData) async {
    final prompt = _buildPrompt(userData);
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    return response.text ?? '';
  }

  String _buildPrompt(Map<String, dynamic> userData) {
    // Build a detailed prompt with user data for the model
    return '''
    Based on the following user details, please provide a personalized meal recommendation for a week. 

    **Personal Information:**
    - Date of Birth: ${userData['dob']}
    - Gender: ${userData['gender']}

    **Physical Information:**
    - Weight: ${userData['weight']} kg
    - Height: ${userData['height']} cm

    **Dietary Preferences:**
    - Diet Type: ${userData['dietType']}
    - Allergies: ${userData['allergies'].join(', ')}
    - Cuisines: ${userData['cuisines'].join(', ')}
    - Disliked Foods: ${userData['dislikedFoods']}

    **Fitness Goals:**
    - Goal: ${userData['goal']}
    - Target Weight: ${userData['targetWeight']} kg
    - Timeline: ${userData['timeline']}

    **Meal Preferences:**
    - Meals per day: ${userData['mealsPerDay']}
    - Meal Timings: ${userData['mealTimings'].join(', ')}

    Please provide a detailed meal plan for a week, including breakfast, lunch, dinner, and snacks. 
    Also, provide a brief explanation of why this meal plan is suitable for the user.
    ''';
  }
}
