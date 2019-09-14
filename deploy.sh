#!/usr/bin/env bash

export LIVEBOOK_HOST=${FLUTTER_WIDGET_LIVEBOOK_HOST}
export LIVEBOOK_USER=${FLUTTER_WIDGET_LIVEBOOK_USER}
export LIVEBOOK_ROOT=${FLUTTER_WIDGET_LIVEBOOK_ROOT}
export LIVEBOOK_UIEXPLORER_HOST=${FLUTTER_WIDGET_LIVEBOOK_UIEXPLORER_HOST}
export LIVEBOOK_UIEXPLORER_USER=${FLUTTER_WIDGET_LIVEBOOK_UIEXPLORER_USER}
export LIVEBOOK_UIEXPLORER_ROOT=${FLUTTER_WIDGET_LIVEBOOK_UIEXPLORER_ROOT}

# Deploy uiexplorer
cd uiexplorer
rm -rf build
flutter build web
flutter test gendb.dart
mv db.json build/web/assets
rsync -az build/web/ "${LIVEBOOK_UIEXPLORER_USER}"@"${LIVEBOOK_UIEXPLORER_HOST}":"${LIVEBOOK_UIEXPLORER_ROOT}" --verbose
cd ../

# Deploy website
rm -rf .cache && rm -rf public
yarn build
rsync -az public/ "${LIVEBOOK_USER}"@"${LIVEBOOK_HOST}":"${LIVEBOOK_ROOT}" --verbose
