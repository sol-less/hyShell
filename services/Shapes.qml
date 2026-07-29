// services/Shapes.qml
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property var loadingPool: [4, 6, 7, 9, 12, 8]

    function randomSides(excludeValue) {
        let pick = excludeValue;
        while (pick === excludeValue) {
            pick = loadingPool[Math.floor(Math.random() * loadingPool.length)];
        }
        return pick;
    }

    function circlePath(w, h) {
        const rx = w / 2, ry = h / 2;
        return `M ${w / 2},0 A ${rx},${ry} 0 1,1 ${w / 2 - 0.01},0 Z`;
    }

    function pillPath(w, h) {
        const r = h / 2;
        return `M ${r},0 L ${w - r},0 A ${r},${r} 0 0,1 ${w - r},${h} L ${r},${h} A ${r},${r} 0 0,1 ${r},0 Z`;
    }

    function squirclePath(w, h, cornerRatio) {
        const cr = cornerRatio === undefined ? 0.3 : cornerRatio;
        const rx = w * cr, ry = h * cr;
        return `M ${rx},0 L ${w - rx},0 Q ${w},0 ${w},${ry} L ${w},${h - ry} Q ${w},${h} ${w - rx},${h} ` + `L ${rx},${h} Q 0,${h} 0,${h - ry} L 0,${ry} Q 0,0 ${rx},0 Z`;
    }

    function archPath(w, h) {
        const r = w / 2;
        return `M 0,${h} L 0,${r} A ${r},${r} 0 0,1 ${w},${r} L ${w},${h} Z`;
    }

    function semicirclePath(w, h) {
        const r = w / 2;
        return `M 0,${h} A ${r},${h} 0 0,1 ${w},${h} Z`;
    }

    function diamondPath(w, h) {
        return `M ${w / 2},0 L ${w},${h / 2} L ${w / 2},${h} L 0,${h / 2} Z`;
    }

    function clamshellPath(w, h) {
        const bulge = h * 0.35;
        return `M ${h / 2},0 L ${w - h / 2},0 A ${h / 2},${h / 2} 0 0,1 ${w - h / 2},${h} ` + `L ${h / 2},${h} A ${h / 2},${h / 2} 0 0,1 ${h / 2},0 ` + `M 0,${h / 2 - bulge} Q ${h * 0.3},${h / 2} 0,${h / 2 + bulge}`;
    }

    function cookiePath(w, h, sides, wobble) {
        const n = sides === undefined ? 8 : sides;
        const wob = wobble === undefined ? 0.08 : wobble;
        const cx = w / 2, cy = h / 2;
        const rOuter = Math.min(w, h) / 2;
        const rInner = rOuter * (1 - wob);
        const points = n * 2;
        const pts = [];
        for (let i = 0; i < points; i++) {
            const angle = (Math.PI * 2 * i) / points - Math.PI / 2;
            const r = i % 2 === 0 ? rOuter : rInner;
            pts.push({
                x: cx + r * Math.cos(angle),
                y: cy + r * Math.sin(angle)
            });
        }
        let path = `M ${pts[0].x},${pts[0].y}`;
        for (let i = 0; i < points; i++) {
            const p0 = pts[(i - 1 + points) % points];
            const p1 = pts[i];
            const p2 = pts[(i + 1) % points];
            const p3 = pts[(i + 2) % points];
            const c1x = p1.x + (p2.x - p0.x) / 6;
            const c1y = p1.y + (p2.y - p0.y) / 6;
            const c2x = p2.x - (p3.x - p1.x) / 6;
            const c2y = p2.y - (p3.y - p1.y) / 6;
            path += ` C ${c1x},${c1y} ${c2x},${c2y} ${p2.x},${p2.y}`;
        }
        return path + " Z";
    }

    function burstPath(w, h, spikes, sharp) {
        const n = spikes === undefined ? 12 : spikes;
        const isSharp = sharp === undefined ? true : sharp;
        const cx = w / 2, cy = h / 2;
        const rOuter = Math.min(w, h) / 2;
        const rInner = rOuter * (isSharp ? 0.55 : 0.75);
        const points = n * 2;
        let path = "";
        for (let i = 0; i < points; i++) {
            const angle = (Math.PI * 2 * i) / points - Math.PI / 2;
            const r = i % 2 === 0 ? rOuter : rInner;
            const x = cx + r * Math.cos(angle);
            const y = cy + r * Math.sin(angle);
            path += (i === 0 ? `M ${x},${y}` : ` L ${x},${y}`);
        }
        return path + " Z";
    }

    function heartPath(w, h) {
        return `M ${w / 2},${h * 0.3} ` + `C ${w / 2},${h * 0.1} ${w * 0.2},0 ${w * 0.05},${h * 0.25} ` + `C ${-w * 0.1},${h * 0.55} ${w * 0.15},${h * 0.75} ${w / 2},${h} ` + `C ${w * 0.85},${h * 0.75} ${w * 1.1},${h * 0.55} ${w * 0.95},${h * 0.25} ` + `C ${w * 0.8},0 ${w / 2},${h * 0.1} ${w / 2},${h * 0.3} Z`;
    }
}
