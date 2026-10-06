#!/usr/bin/env bash
# Planets APK derleme betiği (Gradle / Android Studio gerekmez).
# Gerekenler: Java 17+, apktool.jar (3.x), apksigner.jar, zipalign (Android build-tools), kendi imza anahtarın.
# Kullanım: APKTOOL=apktool.jar APKSIGNER=apksigner.jar KEYSTORE=planets.jks KS_PASS=sifre ./build-apk.sh
set -euo pipefail
: "${APKTOOL:?apktool.jar yolu}" "${APKSIGNER:?apksigner.jar yolu}" "${KEYSTORE:?imza anahtarı (.jks)}" "${KS_PASS:?anahtar şifresi}"
mkdir -p build android/assets
cp index.html android/assets/index.html
java -jar "$APKTOOL" b android -o build/unsigned.apk
zipalign -f 4 build/unsigned.apk build/aligned.apk
java -jar "$APKSIGNER" sign --ks "$KEYSTORE" --ks-pass "pass:$KS_PASS" --min-sdk-version 23 --out build/Planets.apk build/aligned.apk
echo "Hazır: build/Planets.apk"
