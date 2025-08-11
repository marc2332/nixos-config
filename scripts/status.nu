
if (systemctl is-active --user protonmail-bridge.service) == "active" {
    print "🌉 ✅ Proton Mail bridge is running."
} else {
    print "🌉 ❌ Proton Mail bridge is not running."
}

if (systemctl is-active jellyfin.service) == "active" {
    print "🎥 ✅ Jellyfin is running."
} else {
    print "🎥 ❌ Jellyfin is not running."
}

if (systemctl is-active tailscale.service) == "active" {
    print "🎥 ✅ Tailscale is running."
} else {
    print "🎥 ❌ Tailscale is not running."
}