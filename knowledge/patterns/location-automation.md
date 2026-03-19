# Location Automation
> Geofencing, cell-based detection, Get Location v2, and battery-efficient location patterns in Tasker.

## Key Facts
- **Location context** in profiles provides geofencing (lat/lon/radius trigger)
- **Cell Near** state detects area without GPS -- uses cell tower IDs, much lower battery impact
- **WiFi Near** state detects indoor location by nearby WiFi SSIDs/BSSIDs
- **Get Location v2** action (code 366) retrieves current coordinates on demand
- Android 8+ restricts background location -- Tasker needs "Allow all the time" location permission
- Battery impact scales: Cell Near (lowest) < WiFi Near < Network location < GPS (highest)

## Details

### Geofencing with Location Context
Create a profile with Location context for geofenced automation:

1. **Profiles tab > + > State > Location**
2. Set latitude, longitude, and radius
3. Map view: long-press to set center point, drag circle to set radius
4. Link entry/exit tasks

**Parameters:**
| Parameter | Description |
|-----------|-------------|
| Latitude | Decimal degrees (e.g., 37.7749) |
| Longitude | Decimal degrees (e.g., -122.4194) |
| Radius | Meters (minimum ~100m for GPS, ~500m for network) |
| Provider | GPS / Network / Both |

**How it works:**
- Tasker periodically checks location against the defined geofence
- Entering the radius triggers the entry task
- Leaving the radius triggers the exit task
- Check interval is configurable in Tasker Preferences > Monitor > Location Check

### Cell Near State
Detect geographic areas without GPS using cell tower IDs:

1. **Profiles > + > State > Cell Near**
2. At the target location, tap **Scan** to record current cell tower IDs
3. Set **Ignore Toggle**: number of cell changes before triggering exit (reduces false exits)

**Advantages:**
- Near-zero battery impact (piggybacks on existing cell connections)
- Works indoors
- No location permission needed (uses phone state)
- Good for city-block to neighborhood scale detection

**Limitations:**
- Accuracy varies: urban areas (200-500m), rural areas (2-10km)
- Cell towers can change without physical movement (load balancing)
- Not available on WiFi-only tablets

**Best practice:** Scan cell towers multiple times over several days at the target location to capture all towers the device connects to there.

### WiFi Near State
Detect locations by nearby WiFi networks:

1. **Profiles > + > State > WiFi Near**
2. Set SSID or BSSID patterns to match
3. Optional: set signal strength threshold

**Use cases:**
- Office detection (connect to office WiFi)
- Home detection (home router BSSID)
- Store/building detection (public WiFi presence)

**BSSID vs SSID:**
- SSID: network name (e.g., "OfficeWiFi") -- can match multiple access points
- BSSID: MAC address (e.g., "AA:BB:CC:DD:EE:FF") -- matches exact access point
- Use BSSID for precision; use SSID for broader matching

### Get Location v2 Action
On-demand location retrieval (replaces legacy Get Location):

```
Get Location v2
  Source: GPS (or Network, or Both)
  Timeout: 30 seconds
  Accuracy: 10 meters
```

**Output variables:**
| Variable | Content |
|----------|---------|
| `%gl_latitude` | Latitude in decimal degrees |
| `%gl_longitude` | Longitude in decimal degrees |
| `%gl_accuracy` | Accuracy in meters |
| `%gl_altitude` | Altitude in meters |
| `%gl_bearing` | Bearing in degrees |
| `%gl_speed` | Speed in m/s |
| `%gl_time` | Fix timestamp |

**Source options:**
- **GPS**: Most accurate (1-10m), highest battery use, requires sky visibility
- **Network**: Less accurate (50-500m), lower battery, works indoors
- **Both**: Tries both, returns best result

### Background Location Restrictions (Android 8+)

#### Android 10+
- Location permission split: "While using the app" vs "Allow all the time"
- Tasker needs "Allow all the time" for background geofencing
- Setting > Apps > Tasker > Permissions > Location > Allow all the time

#### Android 12+
- Approximate vs Precise location permission split
- Tasker needs Precise location for accurate geofencing
- System may prompt to downgrade to Approximate periodically

#### Android 14+
- More aggressive throttling of background location requests
- Foreground service with location type required for continuous tracking
- Tasker handles this automatically with its monitoring service

### Battery Impact and Accuracy Trade-offs

| Method | Battery Impact | Accuracy | Use Case |
|--------|---------------|----------|----------|
| Cell Near | Minimal | 200m-10km | City area detection |
| WiFi Near | Low | Building-level | Office/home detection |
| Network location | Medium | 50-500m | Neighborhood-level |
| GPS | High | 1-10m | Precise geofencing |
| Passive (all sources) | None | Varies | Opportunistic updates |

**Reducing battery impact:**
1. Use Cell Near as a "coarse trigger" that activates GPS-based geofencing only when near the target area
2. Increase location check interval (Preferences > Monitor > Location Check)
3. Use WiFi Connected state instead of WiFi Near when possible (no scanning needed)
4. Combine Net location with large radius instead of GPS with small radius
5. Use Time context to limit location checks to relevant hours

### Layered Location Pattern
Combine multiple methods for accuracy with battery efficiency:

```
Profile 1: Cell Near [office area cells]
  Entry Task: Enable GPS Geofence
    → Profile Status action: enable Profile 2
  Exit Task: Disable GPS Geofence
    → Profile Status action: disable Profile 2

Profile 2: Location [office lat/lon, 100m radius, GPS] (initially disabled)
  Entry Task: Arrived at Office
  Exit Task: Left Office
```

This uses near-zero-battery cell detection to gate expensive GPS checks.

### Distance Calculation
Calculate distance between two coordinates:
```
Variable Set %lat1 To 37.7749
Variable Set %lon1 To -122.4194
Variable Set %lat2 To %gl_latitude
Variable Set %lon2 To %gl_longitude
JavaScriptlet
  Code:
    var R = 6371000;
    var dLat = (%lat2 - %lat1) * Math.PI / 180;
    var dLon = (%lon2 - %lon1) * Math.PI / 180;
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(%lat1 * Math.PI / 180) * Math.cos(%lat2 * Math.PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
    var distance = R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    setLocal("distance_m", Math.round(distance));
```

## Gotchas
- **"Allow all the time" location is required** for background geofencing -- "While using" permission is insufficient
- **Cell Near requires multiple scans** -- a single scan may miss towers the device uses at different times
- **GPS timeout**: Get Location v2 may fail to get a fix indoors -- always set a timeout and handle failure
- **Location check interval** affects response time -- shorter = faster detection but more battery use
- **WiFi scanning throttling** (Android 9+): only 4 scans per 2 minutes in foreground, 1 per 30 minutes in background
- **Mock locations** (developer options) can fool Tasker's location contexts -- disable for production automations
- **Large geofence radius** needed for network-only location (500m+) due to lower accuracy

## Related
- [[profiles-and-contexts.md]] -- profile states and event contexts
- [[android-version-compat.md]] -- location permission changes by Android version
- [[permission-issues.md]] -- granting location permissions
- [[debugging.md]] -- debugging location-based automations
