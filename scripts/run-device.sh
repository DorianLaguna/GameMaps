#!/usr/bin/env bash
#
# Compila GameMaps, lo instala y lo abre en tu iPhone conectado.
#
# Uso:
#   ./scripts/run-device.sh          # detecta el primer iPhone emparejado
#   ./scripts/run-device.sh <UDID>   # usa un dispositivo especifico
#
set -euo pipefail
cd "$(dirname "$0")/.."

PROJECT="GameMaps.xcodeproj"
SCHEME="GameMaps"
BUNDLE_ID="com.dorianlaguna.GameMaps"
CONFIG="Debug"
DERIVED="build"
APP="$DERIVED/Build/Products/$CONFIG-iphoneos/GameMaps.app"

# 1) Buscar el iPhone
UDID="${1:-}"
if [[ -z "$UDID" ]]; then
  JSON="$(mktemp)"
  xcrun devicectl list devices --json-output "$JSON" >/dev/null
  UDID="$(/usr/bin/python3 - "$JSON" <<'PY'
import json, sys
data = json.load(open(sys.argv[1]))
for dev in data.get("result", {}).get("devices", []):
    hw = dev.get("hardwareProperties", {})
    paired = dev.get("connectionProperties", {}).get("pairingState") == "paired"
    if hw.get("platform") == "iOS" and hw.get("deviceType") == "iPhone" and paired:
        print(hw.get("udid", ""))
        break
PY
)"
  rm -f "$JSON"
fi

if [[ -z "$UDID" ]]; then
  echo "No encontre ningun iPhone emparejado."
  echo "Conectalo por cable, desbloquealo y acepta 'Confiar en esta computadora'."
  echo "Para ver los dispositivos: xcrun devicectl list devices"
  exit 1
fi

# 2) Compilar
echo "==> Compilando $SCHEME ($CONFIG) para $UDID ..."
xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration "$CONFIG" \
  -destination "id=$UDID" \
  -derivedDataPath "$DERIVED" \
  -allowProvisioningUpdates \
  -quiet \
  build

# 3) Instalar
echo "==> Instalando en el iPhone ..."
xcrun devicectl device install app --device "$UDID" "$APP"

# 4) Abrir
echo "==> Abriendo la app ..."
xcrun devicectl device process launch --device "$UDID" --terminate-existing "$BUNDLE_ID"

echo "==> Listo."
