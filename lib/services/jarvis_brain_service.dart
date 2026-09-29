import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarve_j/core/models/jarvis_state.dart';
import 'package:jarve_j/core/models/chat_message.dart';

class JarvisBrainService extends ChangeNotifier {
  JarvisStatus _status = JarvisStatus.idle;
  JarvisStatus get status => _status;

  final List<ChatMessage> _messages = [
    ChatMessage.jarvis(
      'Good day, sir. All quantum protocols and subsystems are functioning at peak efficiency. How may I assist you today?',
      toolUsed: 'system_initialization()',
      actionStatus: 'SUCCESS',
    ),
  ];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void setStatus(JarvisStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      notifyListeners();
    }
  }

  void toggleStatus() {
    switch (_status) {
      case JarvisStatus.idle:
        setStatus(JarvisStatus.listening);
        break;
      case JarvisStatus.listening:
        setStatus(JarvisStatus.thinking);
        break;
      case JarvisStatus.thinking:
        setStatus(JarvisStatus.speaking);
        break;
      case JarvisStatus.speaking:
      case JarvisStatus.error:
        setStatus(JarvisStatus.idle);
        break;
    }
  }

  Future<void> processUserInput(String text) async {
    final query = text.trim();
    if (query.isEmpty) return;

    // 1. Add User Message
    _messages.add(ChatMessage.user(query));
    setStatus(JarvisStatus.thinking);
    notifyListeners();

    // 2. Simulate AI Intent Parsing & Tool Execution
    await Future.delayed(const Duration(milliseconds: 1200));

    final lower = query.toLowerCase();
    String responseText = '';
    String? toolName;
    String? toolStatus;

    if (lower.contains('time') || lower.contains('date')) {
      toolName = 'get_current_time()';
      toolStatus = 'EXECUTED';
      final now = DateTime.now();
      responseText = 'Sir, the local time is ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} on ${now.day}/${now.month}/${now.year}.';
    } else if (lower.contains('system') || lower.contains('status') || lower.contains('health')) {
      toolName = 'get_system_information()';
      toolStatus = 'EXECUTED';
      responseText = 'Core subsystems are operating at optimal parameters. CPU load is normal, neural buffers are clear, and network encryption is verified.';
    } else if (lower.contains('task') || lower.contains('remind')) {
      toolName = 'create_task()';
      toolStatus = 'CONFIRMED';
      responseText = 'I have logged that into your active task scheduler. Would you like me to set an alert protocol as well?';
    } else if (lower.contains('java') || lower.contains('study')) {
      toolName = 'activate_study_module(topic="Java")';
      toolStatus = 'READY';
      responseText = 'Java Study Protocol initiated. In Java, memory management is handled by the JVM Garbage Collector. Would you like to review Object-Oriented Principles or Data Structures first?';
    } else if (lower.contains('code') || lower.contains('debug')) {
      toolName = 'analyze_code_snippet()';
      toolStatus = 'ANALYZED';
      responseText = 'Code diagnostic engine is ready. Please paste the stack trace or code block, and I will isolate any anomalies.';
    } else if (lower.contains('open') || lower.contains('app')) {
      toolName = 'open_application()';
      toolStatus = 'ACTION_PENDING';
      responseText = 'Permission protocol requested: Opening requested application. Execution confirmed.';
    } else {
      responseText = 'Understood, sir. I have processed your inquiry: "$query". Standing by for your next command.';
    }

    // 3. Set to Speaking State
    setStatus(JarvisStatus.speaking);
    _messages.add(
      ChatMessage.jarvis(
        responseText,
        toolUsed: toolName,
        actionStatus: toolStatus,
      ),
    );
    notifyListeners();

    // 4. Reset to Idle after speech duration
    await Future.delayed(const Duration(milliseconds: 2200));
    if (_status == JarvisStatus.speaking) {
      setStatus(JarvisStatus.idle);
      notifyListeners();
    }
  }

  void clearHistory() {
    _messages.clear();
    _messages.add(
      ChatMessage.jarvis(
        'Conversation buffer cleared, sir. Ready for fresh directives.',
        toolUsed: 'clear_memory()',
        actionStatus: 'SUCCESS',
      ),
    );
    notifyListeners();
  }
}
