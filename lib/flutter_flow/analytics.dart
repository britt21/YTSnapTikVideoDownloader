// Thin bridge to GA4 (gtag) via the window.saTrack helper in web/index.html.
import 'dart:js' as js;

/// Fire a GA4 event. No-op if analytics isn't loaded.
void saTrack(String name, Map<String, dynamic> params) {
  try {
    js.context.callMethod('saTrack', [name, js.JsObject.jsify(params)]);
  } catch (_) {}
}

/// Bare hostname (no scheme, no www) — lets GA4 break down by exact site.
String domainOf(String url) {
  try {
    var u = url.trim();
    if (!u.startsWith('http')) u = 'https://$u';
    var host = Uri.parse(u).host.toLowerCase();
    if (host.startsWith('www.')) host = host.substring(4);
    return host.isEmpty ? 'unknown' : host;
  } catch (_) {
    return 'unknown';
  }
}

const List<String> _adultSites = [
  'pornhub', 'xvideos', 'xnxx', 'xhamster', 'redtube', 'youporn', 'spankbang',
  'brazzers', 'onlyfans', 'chaturbate', 'stripchat', 'eporner', 'tnaflix',
  'beeg', 'motherless', 'porntrex', 'hqporner', 'txxx', 'hclips', '.xxx',
];

/// Coarse category for the pasted link. Adult sites collapse to 'adult'.
String platformOf(String url) {
  final h = domainOf(url);
  if (h.contains('youtu')) return 'youtube';
  if (h.contains('tiktok')) return 'tiktok';
  if (h.contains('instagram')) return 'instagram';
  if (h.contains('snapchat')) return 'snapchat';
  if (h.contains('facebook') || h.contains('fb.watch') || h.contains('fb.com')) {
    return 'facebook';
  }
  if (h.contains('twitter') || h == 'x.com' || h.endsWith('.x.com')) return 'twitter';
  if (h.contains('reddit')) return 'reddit';
  if (h.contains('vimeo')) return 'vimeo';
  if (h.contains('dailymotion') || h.contains('dai.ly')) return 'dailymotion';
  if (h.contains('twitch')) return 'twitch';
  if (h.contains('pinterest') || h.contains('pin.it')) return 'pinterest';
  if (h.contains('soundcloud')) return 'soundcloud';
  for (final a in _adultSites) {
    if (h.contains(a)) return 'adult';
  }
  return 'other';
}
