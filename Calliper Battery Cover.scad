PieceLength = 13.9;
PieceWidth = 16.8;
PieceHeight = 2.4;
SideClipWidth = 2.5;
BackBurrLength = 1.9;
BackBurrHeight = 1.2;
BackDivotLength = PieceLength - 1.4;
RailWidth = 1.0;
RailLength = 11.3;
RailHeight = 0.7;
HoleDiameter = 1.0;
HoleRadius = HoleDiameter / 2;
HoleOffsetFromSide = 4.2;

difference() {
    // Main block
    cube([PieceLength, PieceWidth, PieceHeight], true);
    // Forward slant at top
    translate([7.5, 0, 3]) rotate([0, 45, 0]) cube([5, PieceWidth+.1, 5], true);
    // Backside Burr
    translate([
        -(PieceLength/2)+(BackBurrLength/2)-.1,
        0,
        -(PieceHeight/2)+(BackBurrHeight/2)-.1
    ])
    cube([
        BackBurrLength+.2,
        PieceWidth+.1,
        BackBurrHeight+.2
    ], true);
    // Backside divot
    translate([
        (BackDivotLength/2)-(PieceLength/2)-.1,
        0,
        -(PieceHeight/2)+(BackBurrHeight/2)-.1
    ])
    cube([
        BackDivotLength + .2,
        PieceWidth - (2 * SideClipWidth),
        BackBurrHeight + .2
    ], true);
    // Rails
    for(a = [-1:2:1]) {
        translate([
            (RailLength/2) - (PieceLength/2),
            a * PieceWidth / 2, 
            (2*BackBurrHeight-PieceHeight-RailHeight)/2
        ])  
        cube([RailLength, 2 * RailWidth, RailHeight], true);
        translate([
            (PieceLength/2) - HoleRadius - .2,
            a*((PieceWidth/2) - HoleOffsetFromSide - HoleRadius),
            -(PieceHeight/2)
        ])
        cylinder(2*0.6, HoleRadius, HoleRadius, true, $fn = 20);
    }
    // Arrow
    translate([0, 0, PieceHeight/2])
    cylinder(.4, 3, 3, true, $fn=3);
}

// Supports
OutCropHeight = BackBurrHeight - RailHeight;
OutCropLength = PieceLength - BackBurrLength;
for (a = [-1:2:1]) {
    translate([0, a * ((PieceWidth/2)+3.5), 0])
    cube([PieceLength, 5, PieceHeight], true);
    translate([
        (PieceLength - OutCropLength)/2,
        a * ((PieceWidth/2)+1),
        (OutCropHeight-PieceHeight)/2
    ])
    cube([OutCropLength, 2, OutCropHeight], true);
}