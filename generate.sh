rm -f web/worker.dart.js
rm -f web/worker.dart.min.js
dart run build_runner build --delete-conflicting-outputs -o web:build/web/
cp -f build/web/worker.dart.js web/worker.dart.js
rm -rf build/web
dart run build_runner build --release --delete-conflicting-outputs -o web:build/web/
cp -f build/web/worker.dart.js web/worker.dart.min.js
rm -rf build/web