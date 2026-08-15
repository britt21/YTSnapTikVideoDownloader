import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/analytics.dart';
import '/components/res_componenet_widget.dart';
import '/components/res_componenetmp3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSearching = false;

  // ---- Brand palette (professional, self-contained) ----
  static const Color _bg = Color(0xFFF6F7FB);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _ink = Color(0xFF111827);
  static const Color _muted = Color(0xFF6B7280);
  static const Color _accent = Color(0xFF4F46E5); // indigo
  static const Color _accent2 = Color(0xFF9333EA); // violet
  static const Color _border = Color(0xFFE5E7EB);

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final url = _model.textController.text.trim();
    if (url.isEmpty || _isSearching) return;
    // Track which site the user pasted from (platform category + exact domain).
    saTrack('paste_link', {
      'platform': platformOf(url),
      'domain': domainOf(url),
    });
    FocusScope.of(context).unfocus();
    safeSetState(() => _isSearching = true);
    _model.resolutionsResponse =
        await YTSaveAPIGroup.formatcheckVTreeCall.call(url: url);
    safeSetState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    final resp = _model.resolutionsResponse;
    final jsonBody = resp?.jsonBody ?? '';
    final succeeded = resp?.succeeded ?? false;

    final title = YTSaveAPIGroup.formatcheckVTreeCall.title(jsonBody);
    final thumbnail = YTSaveAPIGroup.formatcheckVTreeCall.thumbnail(jsonBody);
    final videoList =
        YTSaveAPIGroup.formatcheckVTreeCall.videolist(jsonBody)?.toList() ?? [];
    final audioList =
        YTSaveAPIGroup.formatcheckVTreeCall.audiofomats(jsonBody)?.toList() ??
            [];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: _bg,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              _hero(),
              // ---- Results ----
              if (resp != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 920),
                      child: succeeded
                          ? _results(title, thumbnail, videoList, audioList)
                          : _errorCard(),
                    ),
                  ),
                ),
              _platformsSection(),
              _featuresSection(),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- HEADER
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      color: _card,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [_accent, _accent2]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.download_rounded,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Text('Easy Saver',
                      style: GoogleFonts.interTight(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _ink)),
                ],
              ),
              Row(
                children: [
                  _navText('How it works'),
                  const SizedBox(width: 22),
                  _navText('Supported sites'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navText(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w500, color: _muted));

  // ------------------------------------------------------------------ HERO
  Widget _hero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFF9333EA)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text('Fast • Free • No sign-up',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              Text(
                'Download any video, in seconds',
                textAlign: TextAlign.center,
                style: GoogleFonts.interTight(
                    color: Colors.white,
                    fontSize: 40,
                    height: 1.1,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 14),
              Text(
                'Paste a link from YouTube, TikTok, Instagram, Snapchat, Facebook and more. '
                'Grab video in MP4 or audio in MP3 — no app required.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.5),
              ),
              const SizedBox(height: 28),
              _searchBar(),
              const SizedBox(height: 18),
              _platformIconsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 12)),
        ],
      ),
      child: LayoutBuilder(builder: (context, c) {
        final narrow = c.maxWidth < 520;
        final field = TextField(
          controller: _model.textController,
          focusNode: _model.textFieldFocusNode,
          onSubmitted: (_) => _search(),
          textInputAction: TextInputAction.search,
          style: GoogleFonts.inter(fontSize: 15, color: _ink),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Paste any video link here…',
            hintStyle: GoogleFonts.inter(color: _muted, fontSize: 15),
            prefixIcon: const Icon(Icons.link_rounded, color: _muted),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _model.textController!,
              builder: (context, value, _) {
                if (value.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: TextButton.icon(
                      onPressed: () async {
                        final data =
                            await Clipboard.getData('text/plain');
                        final t = data?.text?.trim() ?? '';
                        if (t.isNotEmpty) {
                          _model.textController!.text = t;
                          safeSetState(() {});
                        }
                      },
                      icon: const Icon(Icons.content_paste_rounded,
                          size: 18, color: _accent),
                      label: Text('Paste',
                          style: GoogleFonts.inter(
                              color: _accent,
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ),
                  );
                }
                return IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.close_rounded,
                      color: _muted, size: 20),
                  onPressed: () {
                    _model.textController!.clear();
                    safeSetState(() {});
                  },
                );
              },
            ),
          ),
        );
        final button = SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _isSearching ? null : _search,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 26),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: _isSearching
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.4, color: Colors.white))
                : Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.search_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text('Download',
                        style: GoogleFonts.interTight(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                  ]),
          ),
        );
        if (narrow) {
          return Column(children: [
            Padding(padding: const EdgeInsets.all(6), child: field),
            const SizedBox(height: 6),
            SizedBox(width: double.infinity, child: button),
          ]);
        }
        return Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: field)),
          button,
        ]);
      }),
    );
  }

  Widget _platformIconsRow() {
    final items = <IconData>[
      FontAwesomeIcons.youtube,
      FontAwesomeIcons.tiktok,
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.snapchat,
      FontAwesomeIcons.facebook,
      FontAwesomeIcons.twitter,
    ];
    return Wrap(
      spacing: 22,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: items
          .map((i) => FaIcon(i, color: Colors.white.withOpacity(0.9), size: 22))
          .toList(),
    );
  }

  // --------------------------------------------------------------- RESULTS
  Widget _results(String? title, String? thumbnail, List videoList,
      List audioList) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview
          LayoutBuilder(builder: (context, c) {
            final narrow = c.maxWidth < 560;
            final thumb = ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                (thumbnail == null || thumbnail.isEmpty)
                    ? 'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=600&auto=format'
                    : thumbnail,
                width: narrow ? double.infinity : 240,
                height: narrow ? 190 : 150,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: narrow ? double.infinity : 240,
                  height: narrow ? 190 : 150,
                  color: const Color(0xFFEDEEF3),
                  child: const Icon(Icons.movie_rounded,
                      color: _muted, size: 40),
                ),
              ),
            );
            final info = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (title == null || title.isEmpty) ? 'Untitled video' : title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                      height: 1.25),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  const Icon(Icons.check_circle_rounded,
                      color: Color(0xFF16A34A), size: 18),
                  const SizedBox(width: 6),
                  Text('Ready to download',
                      style: GoogleFonts.inter(
                          color: _muted, fontWeight: FontWeight.w500)),
                ]),
              ],
            );
            if (narrow) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [thumb, const SizedBox(height: 14), info]);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                thumb,
                const SizedBox(width: 18),
                Expanded(child: info),
              ],
            );
          }),
          const SizedBox(height: 22),
          // Quality panels
          LayoutBuilder(builder: (context, c) {
            final video = _qualityPanel(
              'Video',
              Icons.videocam_rounded,
              _accent,
              List.generate(videoList.length, (i) {
                final item = videoList[i];
                return ResComponenetWidget(
                  key: Key('vid_$i'),
                  reslutionn:
                      getJsonField(item, r'''$.resolution''').toString(),
                  filesize: getJsonField(item, r'''$.fileSize''').toString(),
                  videourl: _model.textController.text,
                  videoQualityformat:
                      getJsonField(item, r'''$.id''').toString(),
                );
              }),
              emptyMsg: 'No video formats available for this link.',
            );
            final audio = _qualityPanel(
              'Audio (MP3)',
              Icons.music_note_rounded,
              _accent2,
              List.generate(audioList.length, (i) {
                final item = audioList[i];
                return ResComponenetmp3Widget(
                  key: Key('aud_$i'),
                  reslutionn:
                      getJsonField(item, r'''$.resolution''').toString(),
                  filesize: getJsonField(item, r'''$.fileSize''').toString(),
                  videourl: _model.textController.text,
                  videoQualityformat:
                      getJsonField(item, r'''$.id''').toString(),
                );
              }),
              emptyMsg: 'No audio formats available for this link.',
            );
            if (c.maxWidth < 640) {
              return Column(children: [
                video,
                const SizedBox(height: 16),
                audio
              ]);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: video),
                const SizedBox(width: 16),
                Expanded(child: audio),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _qualityPanel(
      String title, IconData icon, Color color, List<Widget> rows,
      {required String emptyMsg}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(title,
                  style: GoogleFonts.interTight(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ]),
          ),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(emptyMsg,
                  style: GoogleFonts.inter(color: _muted, fontSize: 13)),
            )
          else
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  for (int i = 0; i < rows.length; i++) ...[
                    rows[i],
                    if (i != rows.length - 1)
                      const Divider(height: 8, color: Color(0xFFEDEEF3)),
                  ]
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _errorCard() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFECDD3)),
      ),
      child: Row(children: [
        const Icon(Icons.error_outline_rounded, color: Color(0xFFE11D48)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Couldn’t fetch this link. Check that the URL is correct and public, then try again.',
            style: GoogleFonts.inter(color: const Color(0xFF9F1239)),
          ),
        ),
      ]),
    );
  }

  // ------------------------------------------------------------ PLATFORMS
  Widget _platformsSection() {
    final data = <List<dynamic>>[
      [FontAwesomeIcons.youtube, 'YouTube', const Color(0xFFFF0000)],
      [FontAwesomeIcons.tiktok, 'TikTok', const Color(0xFF010101)],
      [FontAwesomeIcons.instagram, 'Instagram', const Color(0xFFE1306C)],
      [FontAwesomeIcons.snapchat, 'Snapchat', const Color(0xFFFFC300)],
      [FontAwesomeIcons.facebook, 'Facebook', const Color(0xFF1877F2)],
      [FontAwesomeIcons.twitter, 'X / Twitter', const Color(0xFF1DA1F2)],
      [FontAwesomeIcons.music, 'YT Music', const Color(0xFFFF0000)],
      [FontAwesomeIcons.globe, 'Many more', _accent],
    ];
    return Container(
      width: double.infinity,
      color: _bg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(children: [
            Text('Works with your favourite platforms',
                textAlign: TextAlign.center,
                style: GoogleFonts.interTight(
                    fontSize: 26, fontWeight: FontWeight.w800, color: _ink)),
            const SizedBox(height: 8),
            Text('One tool for every link you paste.',
                style: GoogleFonts.inter(color: _muted, fontSize: 15)),
            const SizedBox(height: 28),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: data
                  .map((d) => _platformCard(
                      d[0] as IconData, d[1] as String, d[2] as Color))
                  .toList(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _platformCard(IconData icon, String label, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(children: [
        FaIcon(icon, color: color, size: 30),
        const SizedBox(height: 12),
        Text(label,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, color: _ink, fontSize: 14)),
      ]),
    );
  }

  // ------------------------------------------------------------- FEATURES
  Widget _featuresSection() {
    final feats = <List<dynamic>>[
      [
        Icons.hd_rounded,
        'Multiple qualities',
        'Pick the exact resolution you need, or grab audio-only MP3.'
      ],
      [
        Icons.bolt_rounded,
        'Fast & direct',
        'Links are processed on our servers and streamed straight to you.'
      ],
      [
        Icons.lock_rounded,
        'Private & free',
        'No account, no installs, and we don’t store your downloads.'
      ],
    ];
    return Container(
      width: double.infinity,
      color: _card,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(builder: (context, c) {
            final narrow = c.maxWidth < 720;
            final cards = feats
                .map((f) => _featureCard(
                    f[0] as IconData, f[1] as String, f[2] as String))
                .toList();
            return narrow
                ? Column(
                    children: cards
                        .map((w) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: w))
                        .toList())
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < cards.length; i++) ...[
                        Expanded(child: cards[i]),
                        if (i != cards.length - 1) const SizedBox(width: 18),
                      ]
                    ],
                  );
          }),
        ),
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_accent, _accent2]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 16),
          Text(title,
              style: GoogleFonts.interTight(
                  fontSize: 17, fontWeight: FontWeight.w700, color: _ink)),
          const SizedBox(height: 8),
          Text(body,
              style: GoogleFonts.inter(
                  color: _muted, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- FOOTER
  Widget _footer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F1120),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.download_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text('Easy Saver',
                  style: GoogleFonts.interTight(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17)),
            ]),
            const SizedBox(height: 10),
            Text(
              'Please respect copyright. Only download content you own or have permission to use.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6), fontSize: 12.5),
            ),
            const SizedBox(height: 8),
            Text('© 2026 Easy Saver',
                style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.4), fontSize: 12)),
          ]),
        ),
      ),
    );
  }
}
