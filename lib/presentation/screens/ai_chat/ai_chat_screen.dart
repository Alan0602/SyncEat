

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synceat/data/network/vertex_ai_service.dart';
import 'package:synceat/presentation/controller/bloc/auth_service_bloc.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final VertexAIService _vertexAIService = VertexAIService();
  String _recommendation = '';
  bool _isLoading = false;

  void _getMealRecommendation() async {
    setState(() {
      _isLoading = true;
    });

    final authState = context.read<AuthServiceBloc>().state;
    if (authState is AuthServiceSuccess) {
      final recommendation =
          await _vertexAIService.getMealRecommendation(authState.userDetails);
      setState(() {
        _recommendation = recommendation;
        _isLoading = false;
      });
    } else {
      setState(() {
        _recommendation = 'Could not fetch user details.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Meal Recommendation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Text(_recommendation),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getMealRecommendation,
                child: const Text('Get Meal Recommendation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

