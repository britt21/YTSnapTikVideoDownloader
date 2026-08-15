// In-page download with a real progress bar (web).
// Opens an SSE stream to the engine's /prepare, shows progress, then saves
// the finished file from /file/:id — all without leaving the page.
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/backend/api_requests/api_calls.dart' show kEngineBaseUrl;
import 'analytics.dart';

Future<void> downloadWithProgress(
  BuildContext context, {
  required String url,
  required String fomat,
  required bool isAudio,
}) async {
  if (url.trim().isEmpty) return;

  // User selected a format and pressed Download — the key conversion event.
  final platform = platformOf(url);
  saTrack('select_format', {
    'platform': platform,
    'type': isAudio ? 'mp3' : 'video',
    'resolution': fomat,
  });

  final progress = ValueNotifier<double>(0);
  final status = ValueNotifier<String>('Starting…');
  final base = kEngineBaseUrl;
  final prepUrl =
      '$base/prepare?type=${isAudio ? 'audio' : 'video'}'
      '&url=${Uri.encodeComponent(url)}'
      '&fomat=${Uri.encodeComponent(fomat)}';

  html.EventSource? es;
  var finished = false;

  void closeDialog() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => _ProgressDialog(
      progress: progress,
      status: status,
      isAudio: isAudio,
      onCancel: () {
        finished = true;
        es?.close();
        Navigator.of(ctx).pop();
      },
    ),
  );

  es = html.EventSource(prepUrl);

  es.addEventListener('progress', (e) {
    if (finished) return;
    try {
      final data = jsonDecode((e as html.MessageEvent).data as String);
      final pct = (data['percent'] as num).toDouble();
      progress.value = pct;
      status.value = data['status'] == 'processing'
          ? 'Processing…'
          : 'Downloading…  ${pct.toInt()}%';
    } catch (_) {}
  });

  es.addEventListener('done', (e) {
    if (finished) return;
    finished = true;
    progress.value = 100;
    status.value = 'Saving…';
    try {
      final data = jsonDecode((e as html.MessageEvent).data as String);
      final id = data['id'];
      final name = (data['name'] ?? 'download').toString();
      final fileUrl = '$base/file/$id';
      html.AnchorElement(href: fileUrl)
        ..setAttribute('download', name)
        ..style.display = 'none'
        ..click();
    } catch (_) {}
    saTrack('download_success', {
      'platform': platform,
      'type': isAudio ? 'mp3' : 'video',
      'resolution': fomat,
    });
    es?.close();
    closeDialog();
  });

  es.addEventListener('error', (e) {
    if (finished) return;
    // Distinguish our named 'error' event (has data) from a transport drop.
    String? msg;
    try {
      msg = jsonDecode((e as html.MessageEvent).data as String)['message']
          ?.toString();
    } catch (_) {}
    finished = true;
    saTrack('download_error', {
      'platform': platform,
      'type': isAudio ? 'mp3' : 'video',
      'resolution': fomat,
    });
    es?.close();
    closeDialog();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg ?? 'Download failed. Please try again.')),
      );
    }
  });
}

class _ProgressDialog extends StatelessWidget {
  const _ProgressDialog({
    required this.progress,
    required this.status,
    required this.isAudio,
    required this.onCancel,
  });

  final ValueNotifier<double> progress;
  final ValueNotifier<String> status;
  final bool isAudio;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4F46E5);
    const ink = Color(0xFF111827);
    const muted = Color(0xFF6B7280);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF9333EA)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(isAudio ? Icons.music_note_rounded : Icons.movie_rounded,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Preparing your ${isAudio ? 'audio' : 'video'}',
                  style: GoogleFonts.interTight(
                      fontSize: 17, fontWeight: FontWeight.w700, color: ink),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            ValueListenableBuilder<double>(
              valueListenable: progress,
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: value <= 0 ? null : (value / 100).clamp(0, 1),
                        minHeight: 12,
                        backgroundColor: const Color(0xFFEDEEF3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(accent),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<String>(
                      valueListenable: status,
                      builder: (context, s, __) => Text(
                        s,
                        style: GoogleFonts.inter(color: muted, fontSize: 14),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Large videos can take a moment to process on our servers.',
              style: GoogleFonts.inter(color: muted, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onCancel,
                child: Text('Cancel',
                    style: GoogleFonts.inter(
                        color: muted, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
