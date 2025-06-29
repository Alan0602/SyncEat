import 'package:flutter/material.dart';
import 'dart:math';

import 'package:synceat/presentation/screens/home/home_screen.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({super.key});

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 8; // Remains 9 as structure is unchanged

  // Animation controllers
  late AnimationController _progressAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _slideAnimation;

  // User data
  final Map<String, dynamic> _userData = {};

  // Controllers for text fields
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();
  final TextEditingController _timelineController = TextEditingController();
  final TextEditingController _dislikedFoodsController =
      TextEditingController();

  // Selection variables
  String? _selectedGender;
  String? _selectedBloodGroup;
  String? _selectedDietType;
  String? _selectedActivityLevel;
  List<String> _selectedAllergies = [];
  final List<String> _selectedCuisines = [];
  DateTime? _selectedDOB;
  String? _selectedGoal;
  List<String> _selectedDietaryRestrictions = [];
  int _mealsPerDay = 3;
  List<String> _selectedMealTimings = [];
  List<String> _mealTimes = List.filled(6, ""); // Initialize with empty strings

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimationController.dispose();
    _slideAnimationController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _targetWeightController.dispose();
    _timelineController.dispose();
    _dislikedFoodsController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _currentPage++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _updateProgress();
    }
  }

  void _updateProgress() {
    _progressAnimationController.animateTo((_currentPage + 1) / _totalPages);
  }

  void _completeOnboarding() {
    // Save user data
    _userData['dob'] = _selectedDOB;
    _userData['weight'] = _weightController.text;
    _userData['height'] = _heightController.text;
    _userData['gender'] = _selectedGender;
    _userData['dietType'] = _selectedDietType;
    _userData['activityLevel'] = _selectedActivityLevel;
    _userData['allergies'] = _selectedAllergies;
    _userData['cuisines'] = _selectedCuisines;
    _userData['goal'] = _selectedGoal;
    _userData['targetWeight'] = _targetWeightController.text;
    _userData['timeline'] = _timelineController.text;
    _userData['dietaryRestrictions'] = _selectedDietaryRestrictions;
    _userData['mealsPerDay'] = _mealsPerDay;
    _userData['mealTimings'] =
        _mealTimes
            .sublist(0, _mealsPerDay)
            .where((time) => time.isNotEmpty)
            .toList();
    _userData['dislikedFoods'] = _dislikedFoodsController.text;

    // Navigate to home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _selectedDOB != null && _selectedGender != null;
      case 1:
        return _weightController.text.isNotEmpty &&
            _heightController.text.isNotEmpty;
      case 2:
        return _selectedDietType != null;
      case 3:
        return _selectedActivityLevel != null;
      case 4:
        return _selectedAllergies.isNotEmpty;

      case 5: // Adjust index based on where you place Fitness Goals
        return _selectedGoal != null &&
            _targetWeightController.text.isNotEmpty &&
            _timelineController.text.isNotEmpty;
      case 6: // Adjust index based on where you place Meal Preferences
        bool timesSelected = true;
        for (int i = 0; i < _mealsPerDay; i++) {
          if (_mealTimes[i].isEmpty) {
            timesSelected = false;
            break;
          }
        }
        return _selectedCuisines.isNotEmpty &&
            _mealsPerDay > 0 &&
            timesSelected;

      case 7:
        return _selectedCuisines.isNotEmpty;
      default:
        return true;
    }
  }

  // Calculate BMI based on height (cm) and weight (kg)
  double? _calculateBMI() {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty) {
      return null;
    }
    try {
      double weight = double.parse(_weightController.text);
      double height =
          double.parse(_heightController.text) / 100; // Convert cm to m
      if (height <= 0) return null;
      return weight / pow(height, 2);
    } catch (e) {
      return null;
    }
  }

  // Determine BMI category and feedback
  String _getBMIFeedback(double bmi) {
    if (bmi < 18.5) {
      return "You might benefit from gaining a bit of weight for better health.";
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return "Great job! Your weight-to-height ratio is in a healthy range.";
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return "You're doing well, but consider a balanced diet to maintain optimal health.";
    } else {
      return "Let's work together to achieve a healthier weight for you!";
    }
  }

  // Show date picker for DOB
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDOB ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
        _selectedDOB = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D), Color(0xFFFFFFFF)],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress
              _buildHeader(),

              // Questions
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    _updateProgress();
                  },
                  children: [
                    _buildPersonalInfoQuestion(), // Combined DOB and Gender
                    _buildPhysicalInfoQuestion(),
                    _buildDietTypeQuestion(),
                    _buildActivityLevelQuestion(),
                    _buildAllergiesQuestion(),
                    _buildFitnessGoalsQuestion(), // New Section 1
                    _buildMealPreferencesQuestion(),
                    _buildCuisinePreferencesQuestion(),
                  ],
                ),
              ),

              // Navigation buttons
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                IconButton(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                )
              else
                const SizedBox(width: 48),
              const Text(
                'Profile Setup',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${_currentPage + 1}/$_totalPages',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoQuestion() {
    return _buildQuestionCard(
      title: "Personal Information",
      subtitle: "This helps us personalize your nutrition needs",
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF4ECDC4).withOpacity(0.1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF4ECDC4)),
                  const SizedBox(width: 16),
                  Text(
                    _selectedDOB == null
                        ? "Select your Date of Birth"
                        : "${_selectedDOB!.day}/${_selectedDOB!.month}/${_selectedDOB!.year}",
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          _selectedDOB == null
                              ? Colors.grey.shade600
                              : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "What's your gender?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 12),
          _buildOptionButton("Male", _selectedGender == "Male", () {
            setState(() => _selectedGender = "Male");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Female", _selectedGender == "Female", () {
            setState(() => _selectedGender = "Female");
          }),
          const SizedBox(height: 12),
          _buildOptionButton("Other", _selectedGender == "Other", () {
            setState(() => _selectedGender = "Other");
          }),
        ],
      ),
    );
  }

  Widget _buildPhysicalInfoQuestion() {
    double? bmi = _calculateBMI();
    String feedback = bmi != null ? _getBMIFeedback(bmi) : "";
    return _buildQuestionCard(
      title: "Physical Information",
      subtitle: "Help us calculate your ideal nutrition plan",
      child: Column(
        children: [
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Weight (kg)",
              prefixIcon: const Icon(
                Icons.monitor_weight_outlined,
                color: Color(0xFF4ECDC4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Height (cm)",
              prefixIcon: const Icon(Icons.height, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 20),
          if (bmi != null)
            Column(
              children: [
                Text(
                  'BMI: ${bmi.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4ECDC4),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feedback,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDietTypeQuestion() {
    return _buildQuestionCard(
      title: "What's your diet preference?",
      subtitle: "This helps us recommend suitable meals",
      child: Column(
        children: [
          _buildOptionButton(
            "Vegetarian",
            _selectedDietType == "Vegetarian",
            () {
              setState(() => _selectedDietType = "Vegetarian");
            },
          ),
          const SizedBox(height: 12),
          _buildOptionButton("Vegan", _selectedDietType == "Vegan", () {
            setState(() => _selectedDietType = "Vegan");
          }),
          const SizedBox(height: 12),
          _buildOptionButton(
            "Non-Vegetarian",
            _selectedDietType == "Non-Vegetarian",
            () {
              setState(() => _selectedDietType = "Non-Vegetarian");
            },
          ),
          const SizedBox(height: 12),
          _buildOptionButton(
            "Pescatarian",
            _selectedDietType == "Pescatarian",
            () {
              setState(() => _selectedDietType = "Pescatarian");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLevelQuestion() {
    return _buildQuestionCard(
      title: "What's your activity level?",
      subtitle: "This affects your caloric needs",
      child: Column(
        children: [
          _buildOptionButton(
            "Sedentary (Little to no exercise)",
            _selectedActivityLevel == "Sedentary",
            () {
              setState(() => _selectedActivityLevel = "Sedentary");
            },
          ),
          const SizedBox(height: 12),
          _buildOptionButton(
            "Lightly Active (1-3 days/week)",
            _selectedActivityLevel == "Lightly Active",
            () {
              setState(() => _selectedActivityLevel = "Lightly Active");
            },
          ),
          const SizedBox(height: 12),
          _buildOptionButton(
            "Moderately Active (3-5 days/week)",
            _selectedActivityLevel == "Moderately Active",
            () {
              setState(() => _selectedActivityLevel = "Moderately Active");
            },
          ),
          const SizedBox(height: 12),
          _buildOptionButton(
            "Very Active (6-7 days/week)",
            _selectedActivityLevel == "Very Active",
            () {
              setState(() => _selectedActivityLevel = "Very Active");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllergiesQuestion() {
    return _buildQuestionCard(
      title: "Any food allergies?",
      subtitle: "We'll make sure to avoid these in recommendations",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            [
                  'Nuts',
                  'Dairy',
                  'Gluten',
                  'Shellfish',
                  'Eggs',
                  'Soy',
                  'Fish',
                  'None',
                ]
                .map(
                  (allergy) => _buildChipOption(
                    allergy,
                    _selectedAllergies.contains(allergy),
                    () {
                      setState(() {
                        if (allergy == 'None') {
                          _selectedAllergies = ['None'];
                        } else {
                          _selectedAllergies.remove('None');
                          if (_selectedAllergies.contains(allergy)) {
                            _selectedAllergies.remove(allergy);
                          } else {
                            _selectedAllergies.add(allergy);
                          }
                        }
                      });
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildFitnessGoalsQuestion() {
    return _buildQuestionCard(
      title: "What's your goal?",
      subtitle: "This helps us tailor your fitness and meal plans",
      child: Column(
        children: [
          _buildGoalOption(
            "Lose",
            "Lose weight",
            "Burn fat and get leaner",
            Icons.accessibility_new,
            _selectedGoal == "Lose",
            () {
              setState(() => _selectedGoal = "Lose");
            },
          ),
          const SizedBox(height: 12),
          _buildGoalOption(
            "Gain",
            "Gain weight",
            "Build muscle and increase mass",
            Icons.fitness_center,
            _selectedGoal == "Gain",
            () {
              setState(() => _selectedGoal = "Gain");
            },
          ),
          const SizedBox(height: 12),
          _buildGoalOption(
            "Maintain",
            "Maintain weight",
            "Stay fit and healthy",
            Icons.self_improvement,
            _selectedGoal == "Maintain",
            () {
              setState(() => _selectedGoal = "Maintain");
            },
          ),
          const SizedBox(height: 12),
          _buildGoalOption(
            "Build Muscle",
            "Build Muscle",
            "Increase strength and muscle mass",
            Icons.emoji_people,
            _selectedGoal == "Build Muscle",
            () {
              setState(() => _selectedGoal = "Build Muscle");
            },
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _targetWeightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Target Weight (kg)",
              prefixIcon: const Icon(Icons.flag, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _timelineController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Timeline (weeks/months)",
              prefixIcon: const Icon(Icons.timer, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 24),
          const Text(
            "Any dietary restrictions?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                ['Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free', 'Nut-Free']
                    .map(
                      (restriction) => _buildChipOption(
                        restriction,
                        _selectedDietaryRestrictions.contains(restriction),
                        () {
                          setState(() {
                            if (_selectedDietaryRestrictions.contains(
                              restriction,
                            )) {
                              _selectedDietaryRestrictions.remove(restriction);
                            } else {
                              _selectedDietaryRestrictions.add(restriction);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPreferencesQuestion() {
    return _buildQuestionCard(
      title: "Meal Preferences",
      subtitle: "Help us schedule your meals and preferences",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Meals per day",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                "$_mealsPerDay",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4ECDC4),
                ),
              ),
            ],
          ),
          Slider(
            value: _mealsPerDay.toDouble(),
            min: 1,
            max: 6,
            divisions: 5,
            activeColor: const Color(0xFF4ECDC4),
            inactiveColor: Colors.grey.shade300,
            onChanged: (value) {
              setState(() {
                _mealsPerDay = value.toInt();
                // Reset times beyond the selected number of meals
                for (int i = _mealsPerDay; i < _mealTimes.length; i++) {
                  _mealTimes[i] = "";
                }
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            "Meal Timings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Set a time for each of your $_mealsPerDay meal(s)",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          ...List.generate(_mealsPerDay, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildMealTimeSelector(index),
            );
          }),
          const SizedBox(height: 24),
          const Text(
            "Preferred Cuisines",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                ['Italian', 'Mexican', 'Indian', 'Mediterranean', 'Asian']
                    .map(
                      (cuisine) => _buildChipOption(
                        cuisine,
                        _selectedCuisines.contains(cuisine),
                        () {
                          setState(() {
                            if (_selectedCuisines.contains(cuisine)) {
                              _selectedCuisines.remove(cuisine);
                            } else {
                              _selectedCuisines.add(cuisine);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _dislikedFoodsController,
            decoration: InputDecoration(
              hintText: "Foods you dislike (comma separated)",
              prefixIcon: const Icon(Icons.no_meals, color: Color(0xFF4ECDC4)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFF4ECDC4).withOpacity(0.1),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildMealTimeSelector(int mealIndex) {
    String mealLabel = "Meal ${mealIndex + 1}";
    String selectedTime =
        _mealTimes[mealIndex].isEmpty ? "Select Time" : _mealTimes[mealIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF4ECDC4).withOpacity(0.1),
        border: Border.all(
          color:
              _mealTimes[mealIndex].isEmpty
                  ? Colors.grey.shade300
                  : const Color(0xFF4ECDC4),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          _showTimePickerDialog(mealIndex);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color:
                        _mealTimes[mealIndex].isEmpty
                            ? Colors.grey.shade600
                            : const Color(0xFF4ECDC4),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        selectedTime,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              _mealTimes[mealIndex].isEmpty
                                  ? Colors.grey.shade500
                                  : const Color(0xFF4ECDC4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_drop_down,
                color:
                    _mealTimes[mealIndex].isEmpty
                        ? Colors.grey.shade500
                        : const Color(0xFF4ECDC4),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimePickerDialog(int mealIndex) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        int selectedHour = 7;
        int selectedMinute = 0;
        if (_mealTimes[mealIndex].isNotEmpty) {
          try {
            final parts = _mealTimes[mealIndex].split(':');
            selectedHour = int.parse(parts[0]);
            selectedMinute = int.parse(parts[1]);
          } catch (e) {
            // Default to 7:00 if parsing fails
          }
        }
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            return Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Select Time for Meal ${mealIndex + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hour Picker
                        SizedBox(
                          width: 100,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            overAndUnderCenterOpacity: 0.5,
                            perspective: 0.002,
                            onSelectedItemChanged: (index) {
                              setBottomSheetState(() {
                                selectedHour = 0 + index;
                              });
                            },
                            childDelegate: ListWheelChildLoopingListDelegate(
                              children: List.generate(24, (index) {
                                return Center(
                                  child: Text(
                                    index.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedHour == index
                                              ? const Color(0xFF4ECDC4)
                                              : Colors.grey.shade400,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4ECDC4),
                          ),
                        ),
                        // Minute Picker
                        SizedBox(
                          width: 100,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            overAndUnderCenterOpacity: 0.5,
                            perspective: 0.002,
                            onSelectedItemChanged: (index) {
                              setBottomSheetState(() {
                                selectedMinute = index * 15;
                              });
                            },
                            childDelegate: ListWheelChildLoopingListDelegate(
                              children: List.generate(4, (index) {
                                final minute = index * 15;
                                return Center(
                                  child: Text(
                                    minute.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedMinute == minute
                                              ? const Color(0xFF4ECDC4)
                                              : Colors.grey.shade400,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Update the parent widget's state to reflect the selected time in the UI
                      setState(() {
                        _mealTimes[mealIndex] =
                            '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ECDC4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGoalOption(
    String title,
    String subtitle,
    String description,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF4ECDC4),
              size: 30,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isSelected
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuisinePreferencesQuestion() {
    return _buildQuestionCard(
      title: "Favorite cuisines?",
      subtitle: "Select all that you enjoy eating",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            [
                  'Indian',
                  'Chinese',
                  'Italian',
                  'Mexican',
                  'Thai',
                  'Japanese',
                  'Mediterranean',
                  'American',
                ]
                .map(
                  (cuisine) => _buildChipOption(
                    cuisine,
                    _selectedCuisines.contains(cuisine),
                    () {
                      setState(() {
                        if (_selectedCuisines.contains(cuisine)) {
                          _selectedCuisines.remove(cuisine);
                        } else {
                          _selectedCuisines.add(cuisine);
                        }
                      });
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildChipOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4ECDC4) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousPage,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4ECDC4),
                  side: const BorderSide(color: Color(0xFF4ECDC4), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _canProceed() ? _nextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(
                  0xFF4ECDC4,
                ).withOpacity(0.5),
                elevation: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentPage == _totalPages - 1 ? 'Complete' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_currentPage != _totalPages - 1) const SizedBox(width: 8),
                  if (_currentPage != _totalPages - 1)
                    const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
