import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/core/models/chat_message.dart';
import 'package:jarve_j/core/models/jarvis_state.dart';
import 'package:jarve_j/services/jarvis_brain_service.dart';
import 'package:jarve_j/widgets/status_badge.dart';

class ChatTab extends StatefulWidget {
  final JarvisBrainService brainService;

  const ChatTab({super.key, required this.brainService});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.brainService.processUserInput(text);
      _textController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.brainService,
      builder: (context, _) {
        final messages = widget.brainService.messages;
        final status = widget.brainService.status;

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: JarvisColors.backgroundSurface.withOpacity(0.9),
            elevation: 0,
            title: const Row(
              children: [
                Icon(Icons.terminal, color: JarvisColors.cyan, size: 20),
                SizedBox(width: 8),
                Text(
                  'NEURAL CHAT STREAM',
                  style: TextStyle(
                    color: JarvisColors.cyan,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: StatusBadge(status: status),
              ),
              IconButton(
                icon: const Icon(Icons.delete_sweep_outlined, color: JarvisColors.textMuted),
                tooltip: 'Clear History',
                onPressed: () => widget.brainService.clearHistory(),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _buildMessageBubble(msg);
                  },
                ),
              ),

              // Processing indicator if AI is thinking
              if (status == JarvisStatus.thinking)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(JarvisColors.amber),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'JARVIS is analyzing intent & selecting tool...',
                        style: TextStyle(
                          color: JarvisColors.amber.withOpacity(0.9),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

              // Input Command Bar
              _buildChatInputBar(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final timeStr = DateFormat('HH:mm').format(msg.timestamp);

    if (msg.isUser) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0052D4), Color(0xFF4364F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeStr,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: JarvisColors.cardBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(16),
                ),
                border: Border.all(color: JarvisColors.borderLight, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: JarvisColors.cyan,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'JARVIS',
                        style: TextStyle(
                          color: JarvisColors.cyan,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        timeStr,
                        style: const TextStyle(
                          color: JarvisColors.textMuted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Display tool execution badge if tool was called
                  if (msg.toolUsed != null) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: JarvisColors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: JarvisColors.cyan.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.build_circle_outlined, size: 12, color: JarvisColors.cyan),
                          const SizedBox(width: 4),
                          Text(
                            'TOOL: ${msg.toolUsed}',
                            style: const TextStyle(
                              color: JarvisColors.cyan,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (msg.actionStatus != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              '[${msg.actionStatus}]',
                              style: const TextStyle(
                                color: JarvisColors.green,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],

                  Text(
                    msg.text,
                    style: const TextStyle(
                      color: JarvisColors.textPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildChatInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: JarvisColors.backgroundSurface,
        border: Border(
          top: BorderSide(color: JarvisColors.borderSubtle, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.mic, color: JarvisColors.green),
              onPressed: () {
                widget.brainService.setStatus(JarvisStatus.listening);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Voice input triggered — Listening...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: JarvisColors.cardBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: JarvisColors.borderLight),
                ),
                child: TextField(
                  controller: _textController,
                  onSubmitted: (_) => _sendMessage(),
                  style: const TextStyle(color: JarvisColors.textPrimary, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Transmit message to JARVIS...',
                    hintStyle: TextStyle(color: JarvisColors.textMuted, fontSize: 13),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: JarvisColors.arcReactorGradient,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_upward_rounded, color: Colors.black, size: 20),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
