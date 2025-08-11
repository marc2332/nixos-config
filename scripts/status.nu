print "hi"
if (systemctl is-active --user protonmail-bridge.service | str trim) == "active" {
    print "🌉 ✅ Proton Mail bridge is running."
} else {
    print "🌉 ❌ Proton Mail bridge is not running."
}

if (systemctl is-active jellyfin.service | str trim) == "active" {
    print "🎥 ✅ Jellyfin is running."
} else {
    print "🎥 ❌ Jellyfin is not running."
}

if (systemctl is-active tailscale.service | str trim) == "active" {
    print "🎥 ✅ Tailscale is running."
} else {
    print "🎥 ❌ Tailscale is not running."
}