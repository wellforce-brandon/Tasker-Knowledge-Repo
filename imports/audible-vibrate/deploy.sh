#!/usr/bin/env bash
# Deploy Audible Vibrate automation to an Android device via ADB.
#
# Usage:
#   ./deploy.sh          # push the full project (recommended)
#   ./deploy.sh tasks    # push only the two tasks
#   ./deploy.sh profile  # push the profile (includes tasks)
#
# Prerequisites:
#   - ADB installed and on PATH
#   - Device connected via USB or wireless ADB
#   - USB debugging enabled on the device

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="/sdcard/Tasker"

# Git Bash (MSYS2) rewrites /sdcard paths -- disable that
export MSYS_NO_PATHCONV=1

# Verify ADB connection
if ! adb devices 2>/dev/null | grep -q 'device$'; then
    echo "ERROR: No ADB device found. Connect your phone and enable USB debugging."
    exit 1
fi

# Ensure target directory exists
adb shell "mkdir -p $DEST" 2>/dev/null

MODE="${1:-project}"

case "$MODE" in
    tasks)
        echo "Pushing entry task (Audible Vibrate On)..."
        adb push "$SCRIPT_DIR/Audible_Vibrate_On.tsk.xml" "$DEST/"
        echo "Pushing exit task (Audible Vibrate Off)..."
        adb push "$SCRIPT_DIR/Audible_Vibrate_Off.tsk.xml" "$DEST/"
        echo ""
        echo "Done! In Tasker:"
        echo "  1. Long-press the TASKS tab > Import"
        echo "  2. Import both task files"
        echo "  3. Create a profile manually with Application context > Audible"
        echo "  4. Link entry task: Audible Vibrate On"
        echo "  5. Link exit task: Audible Vibrate Off"
        ;;
    profile)
        echo "Pushing profile with tasks..."
        adb push "$SCRIPT_DIR/Audible_Vibrate.prf.xml" "$DEST/"
        echo ""
        echo "Done! In Tasker:"
        echo "  1. Long-press the PROFILES tab > Import"
        echo "  2. Select Audible_Vibrate.prf.xml"
        echo "  3. The profile and both tasks will be imported together"
        ;;
    project)
        echo "Pushing full project..."
        adb push "$SCRIPT_DIR/Audible_Vibrate.prj.xml" "$DEST/"
        echo ""
        echo "Done! In Tasker:"
        echo "  1. Long-press the bottom project tab bar > Import"
        echo "  2. Select Audible_Vibrate.prj.xml"
        echo "  3. A new 'Audible Vibrate' project tab appears with everything ready"
        ;;
    *)
        echo "Usage: $0 [tasks|profile|project]"
        exit 1
        ;;
esac

echo ""
echo "How it works:"
echo "  - When Audible (com.audible.application) is in the foreground -> Vibrate mode"
echo "  - When you leave Audible -> Normal ringer mode restored"
