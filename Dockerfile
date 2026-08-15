# Frontend-only Railway deploy.
# Builds the Flutter web app pointing at the ENGINE running on the OTHER Railway
# server, then serves the static build. The engine (API + downloads) is NOT here.
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
COPY . .
RUN flutter pub get
# Bake in the engine API URL. Change this if the engine server URL changes.
RUN flutter build web --release \
    --dart-define=ENGINE_BASE_URL=https://ytsaveweb-production.up.railway.app

# --- Static server for the built app ---
FROM node:22-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build/web ./web
ENV PORT=3000
EXPOSE 3000
# SPA fallback (-s) so Flutter client routes resolve to index.html.
CMD ["sh","-c","serve -s web -l ${PORT:-3000}"]
