/**
  Copyright (C) 2012-2024 by Autodesk, Inc.
  All rights reserved.

  Heidenhain post processor configuration.

  $Revision: 44126 0cb67a9a4015aa9b9f3ea476da3bc356cae6b340 $
  $Date: 2024-05-14 14:54:51 $

  FORKID {6C22D074-6059-43A4-8AD9-B7E2CCA4B6A9}
*/

description = "Hermle C30U";
vendor = "Hermle";
vendorUrl = "https://www.hermle.de/en";
legal = "Copyright (C) 2012-2024 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45702;

longDescription = "5-axis post for Hermle C30U with a Heidenhain 530 control.";

extension = "h";
if (getCodePage() == 932) { // shift-jis is not supported
  setCodePage("ascii");
} else {
  setCodePage("ansi"); // setCodePage("utf-8");
}

capabilities = CAPABILITY_MILLING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(5400); // 15 revolutions
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion

// user-defined properties
properties = {
  writeMachine: {
    title      : "Write machine",
    description: "Output the machine settings in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  writeTools: {
    title      : "Write tool list",
    description: "Output a tool list in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  writeVersion: {
    title      : "Write version",
    description: "Write the version number in the header of the code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  usePlane: {
    title      : "Tilted workplane",
    description: "Specifies the tilted workplane command to use.",
    group      : "multiAxis",
    type       : "enum",
    values     : [
      {id:"none", title:"Use rotary angles"},
      {id:"true", title:"Use Plane Spatial"},
      {id:"false", title:"Use Cycle19"}
    ],
    value: "true",
    scope: "post"
  },
  useFunctionTCPM: {
    title      : "Use function TCPM",
    description: "Specifies whether to use Function TCPM instead of M128/M129.",
    group      : "multiAxis",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  preloadTool: {
    title      : "Preload tool",
    description: "Preloads the next tool at a tool change (if any).",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  expandCycles: {
    title      : "Expand cycles",
    description: "If enabled, unhandled cycles are expanded.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  smoothingTolerance: {
    title      : "Smoothing tolerance",
    description: "Smoothing tolerance (0 for disabled).",
    group      : "preferences",
    type       : "number",
    value      : 1,
    scope      : "post"
  },
  optionalStop: {
    title      : "Optional stop",
    description: "Outputs optional stop code during when necessary in the code.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  structureComments: {
    title      : "Structure comments",
    description: "Shows structure comments.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  safePositionMethod: {
    title      : "Safe Retracts",
    description: "Select your desired retract option. 'Clearance Height' retracts to the operation clearance height.",
    group      : "homePositions",
    type       : "enum",
    values     : [
      {title:"Clearance Height", id:"clearanceHeight"},
      {title:"M91", id:"M91"},
      {title:"M92", id:"M92"}
    ],
    value: "M91",
    scope: "post"
  },
  useM140: {
    title      : "Use M140",
    description: "Specifies to use M140 MB MAX for Z-axis retracts instead of M91/M92 positions.",
    group      : "homePositions",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useSubroutines: {
    title      : "Use subroutines",
    description: "Select your desired subroutine option. 'All Operations' creates subroutines per each operation, 'Cycles' creates subroutines for cycle operations on same holes, and 'Patterns' creates subroutines for patterned operations.",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"No", id:"none"},
      {title:"All Operations", id:"allOperations"},
      {title:"Cycles", id:"cycles"},
      {title:"Patterns", id:"patterns"}
    ],
    value: "none",
    scope: "post"
  },
  machineDefinition: {
    title      : "Machine definition",
    description: "Specifies the file path of the machine definition to use.",
    group      : "configuration",
    type       : "file",
    filters    : "*.machine|Machine Configuration",
    value      : "",
    scope      : "post"
  },
  useParametricFeed: {
    title      : "Parametric feed",
    description: "Specifies the feed value that should be output using a Q value.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  showNotes: {
    title      : "Show notes",
    description: "Writes operation notes as comments in the outputted code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  preferredTilt: {
    title      : "Prefer tilt",
    description: "Specifies which tilt direction is preferred.",
    group      : "multiAxis",
    type       : "integer",
    values     : [
      {id:-1, title:"Negative"},
      {id:0, title:"Either"},
      {id:1, title:"Positive"}
    ],
    value: -1,
    scope: "post"
  },
  toolAsName: {
    title      : "Tool as name",
    description: "If enabled, the tool will be called with the tool description rather than the tool number.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  outputSpindleSpeedForProbing: {
    title      : "Output spindle speed for probing",
    description: "Specifies whether the spindle speed value is needed at the machine tool for probing operations",
    group      : "probing",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  useParkPositionOperation: {
    title      : "Home XY between operations",
    description: "Specifies to do a full retract in Z, X and Y for each operation.",
    group      : "homePositions",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useParkPosition: {
    title      : "Home XY at end",
    description: "Specifies that the machine moves to the home position in XY at the end of the program.",
    group      : "homePositions",
    type       : "boolean",
    value      : false,
    scope      : "post"
  }
};

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
// {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
var coolants = [
  {id:COOLANT_FLOOD, on:[8, 10], off: 9},
  {id:COOLANT_MIST},
  {id:COOLANT_THROUGH_TOOL, on:51, off:52},
  {id:COOLANT_AIR, on: [7, 10], off: 9 },
  {id:COOLANT_AIR_THROUGH_TOOL, on:12, off: 9},
  {id:COOLANT_SUCTION, on: 10, off: 9},
  {id:COOLANT_FLOOD_MIST, on: [8, 7, 10], off: 9},
  {id:COOLANT_FLOOD_THROUGH_TOOL, on:[51, 8, 10], off:[52, 9]},
  {id:COOLANT_OFF, off:9}
];

// fixed settings
var closestABC = false; // choose closest machine angles
var forceMultiAxisIndexing = false; // force multi-axis indexing for 3D programs
var useCycl247 = true; // use CYCL 247 for work offset
var useCycl205 = false; // use CYCL 205 for universal pecking
var useTCPPositioning = false; // enable to use prepositioning with TCP, recommended for head/head or head/table kinematics
var maximumLineLength = 80; // the maximum number of charaters allowed in a line
var minimumCyclePoints = 5; // minimum number of points in cycle operation to consider for subprogram
var allowIndexingWCSProbing = false; // specifies that probe WCS with tool orientation is supported

var WARNING_WORK_OFFSET = 0;

var SUB_UNKNOWN = 0;
var SUB_PATTERN = 1;
var SUB_CYCLE = 2;

// collected state
var blockNumber = 0;
var activeMovements; // do not use by default
var workOffsetLabels = {};
var nextLabel = 1;
var optionalSection = false;
var subprograms = [];
var currentPattern = -1;
var firstPattern = false;
var currentSubprogram;
var definedPatterns = new Array();
var incrementalMode = false;
var cycleSubprogramIsActive = false;
var patternIsActive = false;
var lastOperationComment = "";
var incrementalSubprogram;
var forceSpindleSpeed = false;
var retracted = false; // specifies that the tool has been retracted to the safe plane
probeMultipleFeatures = true;
var logfilePath = "TNC:\\public\\";
var logFileName;

var radiusCompensationTable = new Table(
  [" R0", " RL", " RR"],
  {initial:RADIUS_COMPENSATION_OFF},
  "Invalid radius compensation"
);

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceSign:true});
var abcFormat = createFormat({decimals:3, forceSign:true, scale:DEG});
// var cFormat = createFormat({decimals:3, forceSign:true, scale:DEG, cyclicLimit:2*Math.PI, cyclicSign:1});
var feedFormat = createFormat({decimals:(unit == MM ? 0 : 2), scale:(unit == MM ? 1 : 10)});
var txyzFormat = createFormat({decimals:(unit == MM ? 7 : 8), forceSign:true});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3});
var paFormat = createFormat({decimals:3, forceSign:true, scale:DEG});
var angleFormat = createFormat({decimals:0, scale:DEG});
var pitchFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceSign:true});
var ratioFormat = createFormat({decimals:3});
var mFormat = createFormat({prefix:"M", decimals:0});

// presentation formats
var spatialFormat = createFormat({decimals:(unit == MM ? 3 : 4)});
var taperFormat = angleFormat; // share format

var xOutput = createVariable({prefix:" X"}, xyzFormat);
var yOutput = createVariable({prefix:" Y"}, xyzFormat);
var zOutput = createVariable({onchange:function () {retracted = false;}, prefix:" Z"}, xyzFormat);
var txOutput = createVariable({prefix:" TX", force:true}, txyzFormat);
var tyOutput = createVariable({prefix:" TY", force:true}, txyzFormat);
var tzOutput = createVariable({prefix:" TZ", force:true}, txyzFormat);
var aOutput = createVariable({prefix:" A"}, abcFormat);
var bOutput = createVariable({prefix:" B"}, abcFormat);
var cOutput = createVariable({prefix:" C"}, abcFormat);
var feedOutput = createVariable({prefix:" F"}, feedFormat);

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

/**
  Writes the specified block.
*/
function writeBlock(block) {
  if (optionalSection) {
    writeln("/" + blockNumber + SP + block);
  } else {
    writeln(blockNumber + SP + block);
  }
  ++blockNumber;
}

/**
  Writes the specified block as optional.
*/
function writeOptionalBlock(block) {
  writeln("/" + blockNumber + SP + block);
  ++blockNumber;
}

function formatComment(text) {
  return SP + ";" + text;
}

/** Output a comment. */
function writeComment(text) {
  if (isTextSupported(text)) {
    writeln(blockNumber + formatComment(text)); // some controls may require a block number
    ++blockNumber;
  }
}

/** Adds a structure comment. */
function writeStructureComment(text) {
  if (getProperty("structureComments")) {
    if (isTextSupported(text)) {
      writeln(blockNumber + SP + "* - " + text); // never make optional
      ++blockNumber;
    }
  }
}

/** Writes a separator. */
function writeSeparator() {
  writeComment("-------------------------------------");
}

/** Writes the specified text through the data interface. */
function printData(text) {
  if (isTextSupported(text)) {
    writeln("FN15: PRINT " + text);
  }
}

function onOpen() {

  if (getProperty("machineDefinition")) {
    machineConfiguration = MachineConfiguration.createFromPath(findFile(getProperty("machineDefinition")));
    log("");
    log("Machine configuration:");
    log(getMachineConfigurationAsText(machineConfiguration));
    setMachineConfiguration(machineConfiguration);
    optimizeMachineAngles2(0); // using M128 mode
  } else if (true) {
    // NOTE: setup your machine here
    var aAxis = createAxis({coordinate:0, table:true, axis:[1, 0, 0], range:[-115.0001, 115.0001], preference:getProperty("preferredTilt")});
    //var bAxis = createAxis({coordinate:1, table:true, axis:[0, 1, 0], range:[-120.0001, 120.0001], preference:1});
    var cAxis = createAxis({coordinate:2, table:true, axis:[0, 0, 1], range:[0, 360], cyclic:true});
    machineConfiguration = new MachineConfiguration(aAxis, cAxis);

    setMachineConfiguration(machineConfiguration);
    optimizeMachineAngles2(0); // using M128 mode
  }

  // NOTE: setup your home positions here
  machineConfiguration.setRetractPlane(500.1); // home position Z
  machineConfiguration.setHomePositionX(325.6); // home position X
  machineConfiguration.setHomePositionY(599); // home position Y

  if (!machineConfiguration.isMachineCoordinate(0)) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1)) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2)) {
    cOutput.disable();
  }

  writeBlock(
    "BEGIN PGM" + (programName ? (SP + programName) : "") + ((unit == MM) ? " MM" : " INCH")
  );
  if (programComment) {
    writeComment(programComment);
  }

  { // stock - workpiece
    var workpiece = getWorkpiece();
    var delta = Vector.diff(workpiece.upper, workpiece.lower);
    if (delta.isNonZero()) {
      writeBlock("BLK FORM 0.1 Z X" + xyzFormat.format(workpiece.lower.x) + " Y" + xyzFormat.format(workpiece.lower.y) + " Z" + xyzFormat.format(workpiece.lower.z));
      writeBlock("BLK FORM 0.2 X" + xyzFormat.format(workpiece.upper.x) + " Y" + xyzFormat.format(workpiece.upper.y) + " Z" + xyzFormat.format(workpiece.upper.z));
    }
  }

  if (getProperty("writeVersion")) {
    if ((typeof getHeaderVersion == "function") && getHeaderVersion()) {
      writeComment(localize("post version") + ": " + getHeaderVersion());
    }
    if ((typeof getHeaderDate == "function") && getHeaderDate()) {
      writeComment(localize("post modified") + ": " + getHeaderDate());
    }
  }

  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (getProperty("writeMachine") && (vendor || model || description)) {
    writeSeparator();
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": "  + description);
    }
    writeSeparator();
    writeComment("");
  }

  // dump tool information
  if (getProperty("writeTools")) {
    var tools = getToolTable();
    if (tools.getNumberOfTools() > 0) {
      var zRanges = {};
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        for (var i = 0; i < numberOfSections; ++i) {
          var section = getSection(i);
          var zRange = section.getGlobalZRange();
          var tool = section.getTool();
          if (zRanges[tool.number]) {
            zRanges[tool.number].expandToRange(zRange);
          } else {
            zRanges[tool.number] = zRange;
          }
        }
      }

      writeSeparator();
      writeComment(localize("Tools"));
      for (var i = 0; i < tools.getNumberOfTools(); ++i) {
        var tool = tools.getTool(i);
        var comment = (getProperty("toolAsName") ? "\"" + (tool.description.toUpperCase()) + "\"" : "  #" + tool.number) + " " +
          localize("D") + "=" + spatialFormat.format(tool.diameter) +
          conditional(tool.cornerRadius > 0, " " + localize("CR") + "=" + spatialFormat.format(tool.cornerRadius)) +
          conditional((tool.taperAngle > 0) && (tool.taperAngle < Math.PI), " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg"));
          // conditional(tool.tipAngle > 0, " " + localize("TIP:") + "=" + taperFormat.format(tool.tipAngle) + localize("deg"));
        if (zRanges[tool.number]) {
          comment += " - " + localize("ZMIN") + "=" + xyzFormat.format(zRanges[tool.number].getMinimum());
          comment += " - " + localize("ZMAX") + "=" + xyzFormat.format(zRanges[tool.number].getMaximum());
        }
        comment += " - " + getToolTypeName(tool.type);
        writeComment(comment);
        if (tool.comment) {
          writeComment("    " + tool.comment);
        }
        if (tool.vendor) {
          writeComment("    " + tool.vendor);
        }
        if (tool.productId) {
          writeComment("    " + tool.productId);
        }
      }
      writeSeparator();
      writeComment("");
    }
  }



  //Probing Surface Inspection
  if (typeof inspectionWriteVariables == "function") {
    inspectionWriteVariables();
  }

  if (machineConfiguration.isMultiAxisConfiguration()) {
    setTCP(false);
  }

  // turn A and C axis to 0 on program start
  writeBlock("PLANE RESET TURN F AUTO");
}

function onComment(message) {
  writeComment(message);
}

function invalidateXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/**
  Invalidates the current position and feedrate. Invoke this function to
  force X, Y, Z, A, B, C, and F in the following block.
*/
function invalidate() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
  forceFeed();
}

var currentTolerance = undefined;

function setTolerance(_tolerance) {
  currentTolerance = undefined; // force CYCL32

  var scaleFactor = 1.3;
  var toleranceFormat = createFormat({decimals:4, forceSign:true, minimum:_tolerance > 0 ? (0.0001 / scaleFactor) : 0}); // smoothing cycle only supports 4 decimals
  _tolerance = toleranceFormat.getResultingValue(_tolerance);
  if (_tolerance == currentTolerance) {
    return;
  }
  currentTolerance = _tolerance;
  var outputTolerance = toleranceFormat.format(_tolerance * scaleFactor);
  if (_tolerance > 0) {
    writeBlock("CYCL DEF 32.0 " + localize("TOLERANCE"));
    writeBlock("CYCL DEF 32.1 T" + outputTolerance);
    if (machineConfiguration.isMultiAxisConfiguration()) {
      writeBlock("CYCL DEF 32.2 HSC-MODE:0 TA0.5"); // required for 5-axis support
    }
  } else {
    writeBlock("CYCL DEF 32.0 " + localize("TOLERANCE")); // cancel tolerance
    writeBlock("CYCL DEF 32.1");
  }
}

function getSEQ() {
  var SEQ = "";
  switch (getProperty("preferredTilt")) {
  case -1:
    SEQ = " SEQ-";
    break;
  case 0:
    break;
  case 1:
    SEQ = " SEQ+";
    break;
  default:
    error(localize("Invalid tilt preference."));
  }
  return SEQ;
}

function getSpindleAxisLetter(axis) {
  if (isSameDirection(axis, new Vector(1, 0, 0))) {
    return "X";
  } else if (isSameDirection(axis, new Vector(0, 1, 0))) {
    return "Y";
  } else if (isSameDirection(axis, new Vector(0, 0, 1))) {
    return "Z";
  } else {
    error(localize("Unsuported spindle axis."));
    return 0;
  }
}

var currentWorkPlaneABC = undefined;
var currentWorkPlaneABCTurned = false;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function defineWorkPlane(_section, _setWorkPlane) {
  var abc = new Vector(0, 0, 0);
  if (forceMultiAxisIndexing || (!is3D() && getProperty("usePlane") != "none") || machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
    if (_section.isMultiAxis()) {
      forceWorkPlane();
      cancelTransformation();
    } else {
      if (getProperty("usePlane") == "true") {
        abc = _section.workPlane.getEuler2(EULER_XYZ_S);
        var remaining = Matrix.getXYZRotation(abc).getTransposed().multiply(_section.workPlane);
        setRotation(remaining);
      } else if (getProperty("usePlane") == "false") {
        if (machineConfiguration.isMultiAxisConfiguration()) {
          abc = getWorkPlaneMachineABC(_section.workPlane, _setWorkPlane);
        } else {
          abc = _section.workPlane.getEuler2(EULER_XYZ_S);
          cancelTransformation();
        }
      } else {
        if (machineConfiguration.isMultiAxisConfiguration()) {
          abc = getWorkPlaneMachineABC(_section.workPlane, _setWorkPlane);
        }
      }
      if (_setWorkPlane) {
        setWorkPlane(abc, true, false); // turn
      }
    }
  } else { // pure 3D
    var remaining = _section.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return abc;
    }
    setRotation(remaining);
  }
  return abc;
}

function getTableRot() {
  if (machineConfiguration.isMultiAxisConfiguration() && currentSection.isZOriented() &&
    (machineConfiguration.getAxisU().isTable() || machineConfiguration.getAxisV().isTable())) {
    return " TABLE ROT"; // force physical C-axis rotation
  }
  return "";
}

function setWorkPlane(abc, turn, isPrepositioned) {
  if (!forceMultiAxisIndexing && is3D() && !machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }

  if (!((currentWorkPlaneABC == undefined) ||
        abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
        abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
        abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z) ||
        (!currentWorkPlaneABCTurned && turn))) {
    return; // no change
  }
  currentWorkPlaneABC = abc;
  currentWorkPlaneABCTurned = turn;

  if (turn && !retracted) {
    if (!isPrepositioned) {
      writeRetract(Z);
    }
  }

  if (turn) {
    onCommand(COMMAND_UNLOCK_MULTI_AXIS);
  }

  if (getProperty("usePlane") == "true") {
    var TURN = turn ? " TURN FMAX" : " STAY"; // alternatively slow down with F9999
    if (abc.isNonZero()) {
      writeBlock(
        "PLANE SPATIAL SPA" + abcFormat.format(abc.x) + " SPB" + abcFormat.format(abc.y) + " SPC" + abcFormat.format(abc.z) + TURN + getSEQ() + getTableRot()
      );
      /*
      var W = currentSection.workPlane; // map to global frame
      writeBlock(
        "PLANE VECTOR" +
        " BX" + txyzFormat.format(W.right.x) + " BY" + txyzFormat.format(W.right.y) + " BZ" + txyzFormat.format(W.right.z) +
        " NX" + txyzFormat.format(W.forward.x) + " NY" + txyzFormat.format(W.forward.y) + " NZ" + txyzFormat.format(W.forward.z) + TURN + getSEQ()
      );
      */
    } else {
      writeBlock("PLANE RESET" + TURN);
    }
  } else if (getProperty("usePlane") == "false") {
    writeBlock("CYCL DEF 19.0 " + localize("WORKING PLANE"));
    if (machineConfiguration.isMultiAxisConfiguration()) {
      writeBlock(
        "CYCL DEF 19.1" +
        conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x)) +
        conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y)) +
        conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
      );
    } else {
      writeBlock("CYCL DEF 19.1 A" + abcFormat.format(abc.x) + " B" + abcFormat.format(abc.y) + " C" + abcFormat.format(abc.z));
    }
    if (turn) {
      if (machineConfiguration.isMultiAxisConfiguration()) {
        writeBlock(
          "L" +
          (machineConfiguration.isMachineCoordinate(0) ? " A+Q120" : "") +
          (machineConfiguration.isMachineCoordinate(1) ? " B+Q121" : "") +
          (machineConfiguration.isMachineCoordinate(2) ? " C+Q122" : "") +
          " R0 FMAX"
        );
      }
    }
  } else {
    writeBlock(
      "L" +
      conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x)) +
      conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y)) +
      conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z)) +
      " R0 FMAX"
    );
  }
}

var currentMachineABC;

function getWorkPlaneMachineABC(workPlane, _setWorkPlane) {
  var W = workPlane; // map to global frame

  var abc = machineConfiguration.getABC(W);
  if (closestABC) {
    if (currentMachineABC) {
      abc = machineConfiguration.remapToABC(abc, currentMachineABC);
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }
  } else {
    abc = machineConfiguration.getPreferredABC(abc);
  }

  try {
    abc = machineConfiguration.remapABC(abc);
    if (_setWorkPlane) {
      currentMachineABC = abc;
    }
  } catch (e) {
    error(
      localize("Machine angles not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
  }

  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  var tcp = false; // keep false for CYCL 19
  if (tcp) {
    setRotation(W); // TCP mode
  } else {
    var O = machineConfiguration.getOrientation(abc);
    var R = machineConfiguration.getRemainingOrientation(abc, W);
    setRotation(R);
  }

  return abc;
}

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

/** Maps the specified feed value to Q feed or formatted feed. */
function getFeed(f) {
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return " FQ" + (50 + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      if (!hasParameter("operation:tool_feedTransition")) {
        activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      }
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }

  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
             hasParameter("operation:tool_feedEntry") &&
             hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if ((movements & (1 << MOVEMENT_HIGH_FEED)) || (highFeedMapping != HIGH_FEED_NO_MAPPING)) {
      var feed;
      if (hasParameter("operation:highFeedrateMode") && getParameter("operation:highFeedrateMode") != "disabled") {
        feed = getParameter("operation:highFeedrate");
      } else {
        feed = this.highFeedrate;
      }
      var feedContext = new FeedContext(id, localize("High Feed"), feed);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
      activeMovements[MOVEMENT_RAPID] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedTransition")) {
    if (movements & (1 << MOVEMENT_LINK_TRANSITION)) {
      var feedContext = new FeedContext(id, localize("Transition"), getParameter("operation:tool_feedTransition"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock("FN0: Q" + (50 + feedContext.id) + "=" + feedFormat.format(feedContext.feed) + " ; " + feedContext.description);
  }
}

/** Returns true if the spatial vectors are significantly different. */
function areSpatialVectorsDifferent(_vector1, _vector2) {
  return (xyzFormat.getResultingValue(_vector1.x) != xyzFormat.getResultingValue(_vector2.x)) ||
    (xyzFormat.getResultingValue(_vector1.y) != xyzFormat.getResultingValue(_vector2.y)) ||
    (xyzFormat.getResultingValue(_vector1.z) != xyzFormat.getResultingValue(_vector2.z));
}

/** Returns true if the spatial boxes are a pure translation. */
function areSpatialBoxesTranslated(_box1, _box2) {
  return !areSpatialVectorsDifferent(Vector.diff(_box1[1], _box1[0]), Vector.diff(_box2[1], _box2[0])) &&
    !areSpatialVectorsDifferent(Vector.diff(_box2[0], _box1[0]), Vector.diff(_box2[1], _box1[1]));
}

/** Returns true if the spatial boxes are same. */
function areSpatialBoxesSame(_box1, _box2) {
  return !areSpatialVectorsDifferent(_box1[0], _box2[0]) && !areSpatialVectorsDifferent(_box1[1], _box2[1]);
}

function subprogramDefine(_initialPosition, _abc, _retracted, _zIsOutput) {
  // convert patterns into subprograms
  var usePattern = false;
  patternIsActive = false;
  if (currentSection.isPatterned && currentSection.isPatterned() && (getProperty("useSubroutines") == "patterns")) {
    currentPattern = currentSection.getPatternId();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_PATTERN) && (currentPattern == definedPatterns[i].patternId)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_PATTERN);
      if (usePattern) {
        currentSubprogram = nextLabel++;
      }
      definedPatterns.push({
        patternType    : SUB_PATTERN,
        patternId      : currentPattern,
        subProgram     : currentSubprogram,
        validPattern   : usePattern,
        initialPosition: _initialPosition,
        finalPosition  : _initialPosition
      });
    }

    if (usePattern) {
      if (!_retracted && !_zIsOutput) {
        writeBlock("L" + zOutput.format(_initialPosition.z) + " FMAX");
      }

      // call subprogram
      writeBlock("CALL LBL " + currentSubprogram);
      patternIsActive = true;

      if (firstPattern) {
        subprogramStart(_initialPosition, _abc, incrementalSubprogram);
      } else {
        skipRemainingSection();
        setCurrentPosition(getFramePosition(currentSection.getFinalPosition()));
      }
    }
  }

  // Output cycle operation as subprogram
  if (!usePattern && (getProperty("useSubroutines") == "cycles") && currentSection.doesStrictCycle &&
      (currentSection.getNumberOfCycles() == 1) && currentSection.getNumberOfCyclePoints() >= minimumCyclePoints) {
    var finalPosition = getFramePosition(currentSection.getFinalPosition());
    currentPattern = currentSection.getNumberOfCyclePoints();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_CYCLE) && (currentPattern == definedPatterns[i].patternId) &&
          !areSpatialVectorsDifferent(_initialPosition, definedPatterns[i].initialPosition) &&
          !areSpatialVectorsDifferent(finalPosition, definedPatterns[i].finalPosition)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_CYCLE);
      if (usePattern) {
        currentSubprogram = nextLabel++;
      }
      definedPatterns.push({
        patternType    : SUB_CYCLE,
        patternId      : currentPattern,
        subProgram     : currentSubprogram,
        validPattern   : usePattern,
        initialPosition: _initialPosition,
        finalPosition  : finalPosition
      });
    }
    cycleSubprogramIsActive = usePattern;
  }

  // Output each operation as a subprogram
  if (!usePattern && (getProperty("useSubroutines") == "allOperations")) {
    currentSubprogram = nextLabel++;
    writeBlock("CALL LBL " + currentSubprogram);
    firstPattern = true;
    subprogramStart(_initialPosition, _abc, false);
  }
}

function subprogramStart(_initialPosition, _abc, _incremental) {
  redirectToBuffer();
  var comment = "";
  if (hasParameter("operation-comment")) {
    comment = getParameter("operation-comment");
  }
  writeln(
    "LBL " + currentSubprogram +
    conditional(comment, formatComment(comment.substr(0, maximumLineLength - 2 - 6 - 1)))
  );
  if (_incremental) {
    setIncrementalMode(_initialPosition, _abc);
  }
}

function subprogramEnd() {
  if (firstPattern) {
    writeln("LBL 0");
    subprograms += getRedirectionBuffer();
  }
  invalidate();
  firstPattern = false;
  closeRedirection();
}

function subprogramIsValid(_section, _patternId, _patternType) {
  var sectionId = _section.getId();
  var numberOfSections = getNumberOfSections();
  var validSubprogram = _patternType != SUB_CYCLE;

  var masterPosition = new Array();
  masterPosition[0] = getFramePosition(_section.getInitialPosition());
  masterPosition[1] = getFramePosition(_section.getFinalPosition());
  var tempBox = _section.getBoundingBox();
  var masterBox = new Array();
  masterBox[0] = getFramePosition(tempBox[0]);
  masterBox[1] = getFramePosition(tempBox[1]);

  var rotation = getRotation();
  var translation = getTranslation();
  incrementalSubprogram = undefined;

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);
    if (section.getId() != sectionId) {
      defineWorkPlane(section, false);
      // check for valid pattern
      if (_patternType == SUB_PATTERN) {
        if (section.getPatternId() == _patternId) {
          var patternPosition = new Array();
          patternPosition[0] = getFramePosition(section.getInitialPosition());
          patternPosition[1] = getFramePosition(section.getFinalPosition());
          tempBox = section.getBoundingBox();
          var patternBox = new Array();
          patternBox[0] = getFramePosition(tempBox[0]);
          patternBox[1] = getFramePosition(tempBox[1]);

          if (areSpatialBoxesSame(masterPosition, patternPosition) && areSpatialBoxesSame(masterBox, patternBox) && !section.isMultiAxis()) {
            incrementalSubprogram = incrementalSubprogram ? incrementalSubprogram : false;
          } else if (!areSpatialBoxesTranslated(masterPosition, patternPosition) || !areSpatialBoxesTranslated(masterBox, patternBox)) {
            validSubprogram = false;
            break;
          } else {
            incrementalSubprogram = true;
          }
        }

      // check for valid cycle operation
      } else if (_patternType == SUB_CYCLE) {
        if ((section.getNumberOfCyclePoints() == _patternId) && (section.getNumberOfCycles() == 1)) {
          var patternInitial = getFramePosition(section.getInitialPosition());
          var patternFinal = getFramePosition(section.getFinalPosition());
          if (!areSpatialVectorsDifferent(patternInitial, masterPosition[0]) && !areSpatialVectorsDifferent(patternFinal, masterPosition[1])) {
            validSubprogram = true;
            break;
          }
        }
      }
    }
  }
  setRotation(rotation);
  setTranslation(translation);
  return (validSubprogram);
}

function setAxisMode(_format, _output, _prefix, _value, _incr) {
  var i = _output.isEnabled();
  if (_output == zOutput) {
    _output = _incr ? createIncrementalVariable({onchange:function() {retracted = false;}, prefix:_prefix}, _format) : createVariable({onchange:function() {retracted = false;}, prefix:_prefix}, _format);
  } else {
    _output = _incr ? createIncrementalVariable({prefix:_prefix}, _format) : createVariable({prefix:_prefix}, _format);
  }
  _output.format(_value);
  _output.format(_value);
  i = i ? _output.enable() : _output.disable();
  return _output;
}

function setIncrementalMode(xyz, abc) {
  xOutput = setAxisMode(xyzFormat, xOutput, " IX", xyz.x, true);
  yOutput = setAxisMode(xyzFormat, yOutput, " IY", xyz.y, true);
  zOutput = setAxisMode(xyzFormat, zOutput, " IZ", xyz.z, true);
  aOutput = setAxisMode(abcFormat, aOutput, " IA", abc.x, true);
  bOutput = setAxisMode(abcFormat, bOutput, " IB", abc.y, true);
  cOutput = setAxisMode(abcFormat, cOutput, " IC", abc.z, true);
  incrementalMode = true;
}

function setAbsoluteMode(xyz, abc) {
  if (incrementalMode) {
    xOutput = setAxisMode(xyzFormat, xOutput, " X", xyz.x, false);
    yOutput = setAxisMode(xyzFormat, yOutput, " Y", xyz.y, false);
    zOutput = setAxisMode(xyzFormat, zOutput, " Z", xyz.z, false);
    aOutput = setAxisMode(abcFormat, aOutput, " A", abc.x, false);
    bOutput = setAxisMode(abcFormat, bOutput, " B", abc.y, false);
    cOutput = setAxisMode(abcFormat, cOutput, " C", abc.z, false);
    incrementalMode = false;
  }
}

function onSection() {
  if (getProperty("toolAsName") && !tool.description) {
    if (hasParameter("operation-comment")) {
      error(subst(localize("Tool description is empty in operation \"%1\"."), getParameter("operation-comment").toUpperCase()));
    } else {
      error(localize("Tool description is empty."));
    }
    return;
  }
  var forceToolAndRetract = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var insertToolCall = forceToolAndRetract || isFirstSection() ||
    (currentSection.getForceToolChange && currentSection.getForceToolChange()) ||
    (tool.number != getPreviousSection().getTool().number) ||
    (tool.clockwise != getPreviousSection().getTool().clockwise) ||
    conditional(getProperty("toolAsName"), tool.description != getPreviousSection().getTool().description);
  retracted = false; // specifies that the tool has been retracted to the safe plane
  var zIsOutput = false; // true if the Z-position has been output, used for patterns

  var newWorkOffset = isFirstSection() ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis()) ||
    (currentSection.isOptimizedForMachine() && getPreviousSection().isOptimizedForMachine() &&
    Vector.diff(getPreviousSection().getFinalToolAxisABC(), currentSection.getInitialToolAxisABC()).length > 1e-4) ||
    (!machineConfiguration.isMultiAxisConfiguration() && currentSection.isMultiAxis()) ||
    (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis() ||
      getPreviousSection().isMultiAxis() && !currentSection.isMultiAxis()); // force newWorkPlane between indexing and simultaneous operations
  var fullRetract = insertToolCall || newWorkPlane;

  if (insertToolCall) {
    setCoolant(COOLANT_OFF);
  }

  if (insertToolCall || newWorkOffset || newWorkPlane) {

    if ((forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) && newWorkPlane) { // reset working plane
      onCommand(COMMAND_UNLOCK_MULTI_AXIS);
      if (getProperty("usePlane") == "true") {
        writeBlock("PLANE RESET STAY");
      } else if (getProperty("usePlane") == "false") {
        writeBlock("CYCL DEF 19.0 " + localize("WORKING PLANE"));
        if (machineConfiguration.isMultiAxisConfiguration()) {
          writeBlock(
            "CYCL DEF 19.1" +
            conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(0)) +
            conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(0)) +
            conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(0))
          );
        } else {
          writeBlock("CYCL DEF 19.1 A" + abcFormat.format(0) + " B" + abcFormat.format(0) + " C" + abcFormat.format(0));
        }
      } else {
        // specify code here in case getProperty("usePlane") = "none" if needed
      }
      forceWorkPlane();
    }

    // retract to safe plane
    if (!getProperty("useM140") || !isFirstSection()) { // cannot use M140 here since no tool is called yet which specifies the tool axis for M140
      writeRetract(Z);
    }

    if (fullRetract) {
      // writeRetract(X);
      // writeRetract(Y);
    }
  }

  if (getProperty("useParkPositionOperation")) { // force XY Z retracts
    if (!retracted) {
      writeRetract(Z);
    }
    writeRetract(X);
    writeRetract(Y);
  }

  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (comment && ((comment !== lastOperationComment) || !patternIsActive || insertToolCall)) {
      writeStructureComment(comment);
      lastOperationComment = comment;
    }
  }

  if (getProperty("showNotes") && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }

  if (insertToolCall) {
    forceWorkPlane();

    onCommand(COMMAND_STOP_SPINDLE);

    if (!isFirstSection() && getProperty("optionalStop")) {
      onCommand(COMMAND_STOP_CHIP_TRANSPORT);
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    // if (!isFirstSection()) {
    //   onCommand(COMMAND_BREAK_CONTROL);
    // }

    if (false) {
      var zRange = currentSection.getGlobalZRange();
      var numberOfSections = getNumberOfSections();
      for (var i = getCurrentSectionId() + 1; i < numberOfSections; ++i) {
        var section = getSection(i);
        var _tool = section.getTool();
        if (_tool.number != tool.number) {
          break;
        }
        zRange.expandToRange(section.getGlobalZRange());
      }

      writeStructureComment("T" + tool.number + "-D" + spatialFormat.format(tool.diameter) + "-CR:" + spatialFormat.format(tool.cornerRadius) + "-ZMIN:" + spatialFormat.format(zRange.getMinimum()) + "-ZMAX:" + spatialFormat.format(zRange.getMaximum()));
    }

    writeBlock(
      "TOOL CALL " + (getProperty("toolAsName") ? "\"" + (tool.description.toUpperCase()) + "\"" : tool.number) +
      SP + getSpindleAxisLetter(machineConfiguration.getSpindleAxis()) +
      (tool.type == TOOL_PROBE ? getProperty("outputSpindleSpeedForProbing") ?
        " S" + rpmFormat.format(50) : "" : " S" + rpmFormat.format(spindleSpeed)
      )
    );
    forceSpindleSpeed = false;
    if (tool.comment) {
      writeComment(tool.comment);
    }


    if (getProperty("preloadTool")) {
      var nextTool = (getProperty("toolAsName") ? getNextToolDescription(tool.description) : getNextTool(tool.number));
      if (nextTool) {
        writeBlock("TOOL DEF " + (getProperty("toolAsName") ? "\"" + (nextTool.description.toUpperCase()) + "\"" : nextTool.number));
      } else {
        // preload first tool
        var section = getSection(0);
        var firstToolNumber = section.getTool().number;
        var firstToolDescription = section.getTool().description;
        if (getProperty("toolAsName")) {
          if (tool.description != firstToolDescription) {
            writeBlock("TOOL DEF " + "\"" + (firstToolDescription.toUpperCase()) + "\"");
          }
        } else {
          if (tool.number != firstToolNumber) {
            writeBlock("TOOL DEF " + firstToolNumber);
          }
        }
      }
    }

    if (fullRetract) {
      writeRetract(Z);
      // writeRetract(X);
      // writeRetract(Y);
    } else {
      // simple retract
      writeRetract(Z);
    }

    forceABC();

    onCommand(COMMAND_START_CHIP_TRANSPORT);
    if (!is3D()) {
      writeBlock(mFormat.format(126)); // shortest path traverse
    }
  } else {
    var spindleChanged = (forceSpindleSpeed ||
      (rpmFormat.areDifferent(spindleSpeed, getPreviousSection().getInitialSpindleSpeed ? getPreviousSection().getInitialSpindleSpeed() : getPreviousSection().getTool().spindleRPM)));
    if (spindleChanged) {
      forceSpindleSpeed = false;
      onSpindleSpeed(spindleSpeed);
    }
  }

  if (!isProbeOperation() && !isInspectionOperation(currentSection)) {
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
  }

  setWCS();
  var abc = defineWorkPlane(currentSection, true);

  if (!currentSection.isMultiAxis()) {
    onCommand(COMMAND_LOCK_MULTI_AXIS);
  }

  invalidate();

  if (currentSection.isMultiAxis()) {
    if (!retracted) {
      writeRetract(Z);
    }
    cancelTransformation();
    var abc;
    if (currentSection.isOptimizedForMachine()) {
      abc = currentSection.getInitialToolAxisABC();
      writeBlock(
        "L" +
        aOutput.format(abc.x) +
        bOutput.format(abc.y) +
        cOutput.format(abc.z) +
        " R0 FMAX"
      );
    } else {
      // plane vector set below
    }

    // global position
    var initialPosition = getFramePosition(getGlobalPosition(currentSection.getInitialPosition()));

    if (getProperty("usePlane") != "none") {
      // global position
      writeBlock("CYCL DEF 7.0 " + localize("DATUM SHIFT"));
      writeBlock("CYCL DEF 7.1 X" + xyzFormat.format(initialPosition.x));
      writeBlock("CYCL DEF 7.2 Y" + xyzFormat.format(initialPosition.y));
      writeBlock("CYCL DEF 7.3 Z" + xyzFormat.format(initialPosition.z));
      forceXYZ();
    }

    if (getProperty("usePlane") == "true") {
      if (machineConfiguration.isMultiAxisConfiguration()) {
        writeBlock(
          "PLANE SPATIAL SPA" + abcFormat.format(abc.x % (Math.PI * 2)) + " SPB" + abcFormat.format(abc.y % (Math.PI * 2)) + " SPC" + abcFormat.format(abc.z % (Math.PI * 2)) + " STAY"
        );
      } else {
        // x/y axes do not matter as long as we only move to X0 Y0 below
        var forward = currentSection.getGlobalInitialToolAxis();
        var unitZ = new Vector(0, 0, 1);
        var W;
        if (Math.abs(Vector.dot(forward, unitZ)) < 0.5) {
          var imX = Vector.cross(forward, unitZ).getNormalized();
          W = new Matrix(imX, Vector.cross(forward, imX), forward); // make sure this is orthogonal
        } else {
          var imX = Vector.cross(new Vector(0, 1, 0), forward).getNormalized();
          W = new Matrix(imX, Vector.cross(forward, imX), forward); // make sure this is orthogonal
        }

        var TURN = true ? " TURN FMAX" : " STAY"; // alternatively slow down with F9999
        writeBlock(
          "PLANE VECTOR" +
          " BX" + txyzFormat.format(W.right.x) + " BY" + txyzFormat.format(W.right.y) + " BZ" + txyzFormat.format(W.right.z) +
          " NX" + txyzFormat.format(W.forward.x) + " NY" + txyzFormat.format(W.forward.y) + " NZ" + txyzFormat.format(W.forward.z) + TURN
        );
      }
    } else if (getProperty("usePlane") == "false") {
      writeBlock("CYCL DEF 19.0 " + localize("WORKING PLANE"));
      if (machineConfiguration.isMultiAxisConfiguration()) {
        writeBlock(
          "CYCL DEF 19.1" +
          conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x % (Math.PI * 2))) +
          conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y % (Math.PI * 2))) +
          conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z % (Math.PI * 2)))
        );
      } else {
        error(localize("CYCL DEF 19 is not allowed without a machine configuration (enable the 'usePlane' setting)."));
        writeBlock("CYCL DEF 19.1 A" + abcFormat.format(abc.x) + " B" + abcFormat.format(abc.y) + " C" + abcFormat.format(abc.z));
      }
    } else {
      if (!machineConfiguration.isMultiAxisConfiguration() || !currentSection.isOptimizedForMachine()) {
        error(localize("Multi-axis toolpath is not allowed without a machine configuration."));
        return;
      }
      // specify code here in case getProperty("usePlane") = "none" if needed
    }

    if ((machineConfiguration.isHeadConfiguration() || useTCPPositioning) && (getProperty("usePlane") == "true")) {
      setWorkPlane(new Vector(0, 0, 0), false, false); // reset working plane
      setTCP(true);
    }
    if (getProperty("usePlane") != "none") {
      writeBlock("L" + xOutput.format(0) + yOutput.format(0) + " R0 FMAX");
      writeBlock("L" + zOutput.format(0) + " R0 FMAX");

      writeBlock("CYCL DEF 7.0 " + localize("DATUM SHIFT"));
      writeBlock("CYCL DEF 7.1 X" + xyzFormat.format(0));
      writeBlock("CYCL DEF 7.2 Y" + xyzFormat.format(0));
      writeBlock("CYCL DEF 7.3 Z" + xyzFormat.format(0));
      forceXYZ();
    }
    if (getProperty("usePlane") == "true") {
      if (!useTCPPositioning && !machineConfiguration.isHeadConfiguration()) {
        setWorkPlane(new Vector(0, 0, 0), false, false); // reset working plane
        setTCP(true);
      }
    } else if (getProperty("usePlane") == "false") {
      writeBlock("CYCL DEF 19.0 " + localize("WORKING PLANE"));
      if (machineConfiguration.isMultiAxisConfiguration()) {
        writeBlock(
          "CYCL DEF 19.1" +
          conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(0)) +
          conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(0)) +
          conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(0))
        );
      } else {
        writeBlock("CYCL DEF 19.1 A" + abcFormat.format(0) + " B" + abcFormat.format(0) + " C" + abcFormat.format(0));
      }
      setTCP(true);
    } else {
      setTCP(true);
      if (!machineConfiguration.isHeadConfiguration()) {
        writeBlock("L" + xOutput.format(initialPosition.x) + yOutput.format(initialPosition.y) + " R0 FMAX");
        z = zOutput.format(initialPosition.z);
        if (z) {
          writeBlock("L" + z + " R0 FMAX");
        }
      } else {
        writeBlock("L" + xOutput.format(initialPosition.x) + yOutput.format(initialPosition.y) + zOutput.format(initialPosition.z) + " R0 FMAX");
      }
    }
    forceXYZ();
  } else { // indexing
    var initialPosition = getFramePosition(currentSection.getInitialPosition());
    var globalInitialPosition = getGlobalPosition(currentSection.getInitialPosition());

    if (!retracted && !insertToolCall) {
      if (getCurrentPosition().z < initialPosition.z) {
        writeBlock("L" + zOutput.format(initialPosition.z) + " FMAX");
        zIsOutput = true;
      }
    }
    if ((machineConfiguration.isHeadConfiguration() || useTCPPositioning) && getProperty("usePlane") == "true") { // enable to use prepositioning with TCP, recommended for head/head or head/table kinematics
      if (abc.isNonZero()) {
        setWorkPlane(new Vector(0, 0, 0), false, false); // reset working plane
        setTCP(true);
      }
      writeBlock("L" + xOutput.format(globalInitialPosition.x) + yOutput.format(globalInitialPosition.y) + " R0 FMAX");
      writeBlock("L" + zOutput.format(globalInitialPosition.z) + " R0 FMAX");
      if (abc.isNonZero()) {
        setTCP(false);
        setWorkPlane(abc, true, true); // turn, avoid retracting when already prepositioned
      }
    } else {
      if (!machineConfiguration.isHeadConfiguration()) {
        writeBlock("L" + xOutput.format(initialPosition.x) + yOutput.format(initialPosition.y) + " R0 FMAX");
        z = zOutput.format(initialPosition.z);
        if (z) {
          writeBlock("L" + z + " R0 FMAX");
        }
      } else {
        writeBlock("L" + xOutput.format(initialPosition.x) + yOutput.format(initialPosition.y) + zOutput.format(initialPosition.z) + " R0 FMAX");
      }
    }
    zIsOutput = true;
  }

  // set coolant after we have positioned at Z
  if (insertToolCall && !isFirstSection()) {
    forceCoolant = true;
  }
  setCoolant(tool.coolant);

  if (forceToolAndRetract) {
    currentTolerance = undefined;
  }
  if (hasParameter("operation-strategy") && (getParameter("operation-strategy") == "drill")) {
    setTolerance(0);
  } else if (hasParameter("operation:tolerance")) {
    setTolerance(Math.max(Math.min(getParameter("operation:tolerance"), getProperty("smoothingTolerance")), 0));
  } else {
    setTolerance(0);
  }

  if (getProperty("useParametricFeed") &&
      hasParameter("operation-strategy") &&
      (getParameter("operation-strategy") != "drill") && // legacy
      !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())) {
    if (!insertToolCall &&
        activeMovements &&
        (getCurrentSectionId() > 0) &&
        ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }
  // surface Inspection
  if (isInspectionOperation(currentSection) && (typeof inspectionProcessSectionStart == "function")) {
    inspectionProcessSectionStart();
  }
  // define subprogram
  subprogramDefine(initialPosition, abc, retracted, zIsOutput);
  retracted = false;
}

function setTCP(tcp) {
  if (typeof currentSection == "undefined" ||
    (getProperty("usePlane") == "none" && currentSection.isOptimizedForMachine() && currentSection.getOptimizedTCPMode() != 0)) {
    return;
  }
  if (tcp) {
    if (getProperty("useFunctionTCPM")) {
      writeBlock("FUNCTION TCPM F TCP AXIS POS PATHCTRL AXIS");
    } else {
      writeBlock(mFormat.format(128));
    }
  } else {
    if (getProperty("useFunctionTCPM")) {
      writeBlock("FUNCTION RESET TCPM");
    } else {
      writeBlock(mFormat.format(129));
    }
  }
}

function setWCS() {
  if (currentSection.workOffset > 0) {
    if (currentSection.workOffset > 9999) {
      error(localize("Work offset out of range."));
      return;
    }
    // datum shift after tool call
    if (useCycl247) {
      if (workOffsetLabels[currentSection.workOffset]) {
        writeBlock("CALL LBL " + workOffsetLabels[currentSection.workOffset] + " ;DATUM");
      } else {
        workOffsetLabels[currentSection.workOffset] = nextLabel;
        writeBlock("LBL " + nextLabel);
        ++nextLabel;
        writeBlock(
          "CYCL DEF 247 " + localize("DATUM SETTING") + " ~" + EOL +
          "  Q339=" + currentSection.workOffset + " ; " + localize("DATUM NUMBER")
        );
        writeBlock("LBL 0");
      }
    } else {
      writeBlock("CYCL DEF 7.0 " + localize("DATUM SHIFT"));
      writeBlock("CYCL DEF 7.1 #" + currentSection.workOffset);
    }
  } else {
    // warningOnce(localize("Work offset has not been specified."), WARNING_WORK_OFFSET);
  }
}

function getNextToolDescription(description) {
  var currentSectionId = getCurrentSectionId();
  if (currentSectionId < 0) {
    return null;
  }
  for (var i = currentSectionId + 1; i < getNumberOfSections(); ++i) {
    var section = getSection(i);
    var sectionTool = section.getTool();
    if (description != sectionTool.description) {
      return sectionTool; // found next tool
    }
  }
  return null; // not found
}

function onDwell(seconds) {
  validate(seconds >= 0);
  writeBlock("CYCL DEF 9.0 " + localize("DWELL TIME"));
  writeBlock("CYCL DEF 9.1 DWELL " + secFormat.format(seconds));
}

var probeOutputWorkOffset = 1;

function onParameter(name, value) {
  if (name == "operation-structure-comment") {
    writeStructureComment("  " + value);
  }
  if (name == "probe-output-work-offset") {
    probeOutputWorkOffset = value;
  }
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(
    "TOOL CALL " + getSpindleAxisLetter(machineConfiguration.getSpindleAxis()) +
    (tool.type == TOOL_PROBE ? getProperty("outputSpindleSpeedForProbing") ?
      " S" + rpmFormat.format(50) : "" : " S" + rpmFormat.format(spindleSpeed)
    )
  );
}

function onDrilling(cycle) {
  writeBlock("CYCL DEF 200 " + localize("DRILLING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q202=" + xyzFormat.format(cycle.depth) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
    + "  Q210=" + secFormat.format(0) + " ;" + localize("DWELL AT TOP") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q211=" + secFormat.format(0) + " ;" + localize("DWELL AT BOTTOM")
  );
}

function onCounterBoring(cycle) {
  writeBlock("CYCL DEF 200 " + localize("DRILLING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q202=" + xyzFormat.format(cycle.depth) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
    + "  Q210=" + secFormat.format(0) + " ;" + localize("DWELL AT TOP") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM")
  );
}

function onChipBreaking(cycle) {
  writeBlock("CYCL DEF 203 " + localize("UNIVERSAL DRILLING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q202=" + xyzFormat.format(cycle.incrementalDepth) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
    + "  Q210=" + secFormat.format(0) + " ;" + localize("DWELL AT TOP") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q212=" + xyzFormat.format(cycle.incrementalDepthReduction) + " ;" + localize("DECREMENT") + " ~" + EOL
    + "  Q213=" + cycle.plungesPerRetract + " ;" + localize("BREAKS") + " ~" + EOL
    + "  Q205=" + xyzFormat.format(cycle.minimumIncrementalDepth) + " ;" + localize("MIN. PLUNGING DEPTH") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL TIME AT DEPTH") + " ~" + EOL
    + "  Q208=" + "MAX" + " ;" + localize("RETRACTION FEED RATE") + " ~" + EOL
    + "  Q256=" + xyzFormat.format((cycle.chipBreakDistance != undefined) ? cycle.chipBreakDistance : machineParameters.chipBreakingDistance) + " ;" + localize("DIST. FOR CHIP BRKNG")
  );
}

function onDeepDrilling(cycle) {
  if (useCycl205) {
    writeBlock("CYCL DEF 205 " + localize("UNIVERSAL PECKING") + " ~" + EOL
      + " Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
      + " Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
      + " Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
      + " Q202=" + xyzFormat.format(cycle.incrementalDepth) + " ;" + localize("PLUNGING DEPTH") + " ~" + EOL
      + " Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
      + " Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
      + " Q212=" + xyzFormat.format(cycle.incrementalDepthReduction) + " ;" + localize("DECREMENT") + " ~" + EOL
      + " Q205=" + xyzFormat.format(cycle.minimumIncrementalDepth) + " ;" + localize("MIN. PLUNGING DEPTH") + " ~" + EOL
      + " Q258=" + xyzFormat.format(0.5) + " ;" + localize("UPPER ADV. STOP DIST.") + " ~" + EOL
      + " Q259=" + xyzFormat.format(1) + " ;" + localize("LOWER ADV. STOP DIST.") + " ~" + EOL
      + " Q257=" + xyzFormat.format(5) + " ;" + localize("DEPTH FOR CHIP BRKNG") + " ~" + EOL
      + " Q256=" + xyzFormat.format((cycle.chipBreakDistance != undefined) ? cycle.chipBreakDistance : machineParameters.chipBreakingDistance) + " ;" + localize("DIST. FOR CHIP BRKNG") + " ~" + EOL
      + " Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL TIME AT DEPTH") + " ~" + EOL
      + " Q379=" + "0" + " ;" + localize("STARTING POINT") + " ~" + EOL
      + " Q253=" + feedFormat.format(cycle.retractFeedrate) + " ;" + localize("F PRE-POSITIONING")
    );
  } else {
    writeBlock("CYCL DEF 200 " + localize("DRILLING") + " ~" + EOL
      + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
      + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
      + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
      + "  Q202=" + xyzFormat.format(cycle.incrementalDepth) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
      + "  Q210=" + secFormat.format(0) + " ;" + localize("DWELL AT TOP") + " ~" + EOL
      + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
      + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
      + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM")
    );
  }
}

function onGunDrilling(cycle) {
  var coolantCode = getCoolantCode(tool.coolant);
  writeBlock("CYCL DEF 241 " + localize("SINGLE-FLUTED DEEP-HOLE DRILLING") + " ~" + EOL
    + " Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + " Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + " Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + " Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL TIME AT DEPTH") + " ~" + EOL
    + " Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + " Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + " Q379=" + xyzFormat.format(cycle.startingDepth) + " ;" + localize("STARTING POINT") + " ~" + EOL
    + " Q253=" + feedFormat.format(cycle.positioningFeedrate) + " ;" + localize("F PRE-POSITIONING") + " ~" + EOL
    + " Q208=" + feedFormat.format(cycle.retractFeedrate) + " ;" + localize("RETRACT FEED RATE") + " ~" + EOL
    + " Q426=" + (cycle.stopSpindle ? 5 : (tool.clockwise ? 3 : 4)) + " ;" + localize("DIR. OF SPINDLE ROT.") + " ~" + EOL
    + " Q427=" + rpmFormat.format(cycle.positioningSpindleSpeed ? cycle.positioningSpindleSpeed : tool.spindleRPM) + " ;" + localize("ENTRY EXIT SPEED") + " ~" + EOL
    + " Q428=" + rpmFormat.format(tool.spindleRPM) + " ;" + localize("DRILLING SPEED") + " ~" + EOL
    + conditional(coolantCode, " Q429=" + (coolantCode ? coolantCode[0] : 0) + " ;" + localize("COOLANT ON") + " ~" + EOL)
    + conditional(coolantCode, " Q430=" + (coolantCode ? coolantCode[1] : 0) + " ;" + localize("COOLANT OFF") + " ~" + EOL)
    // Heidenhain manual doesn't specify Q435 fully - adjust to fit CNC
    + " Q435=" + xyzFormat.format(cycle.dwellDepth ? (cycle.depth + cycle.dwellDepth) : 0) + " ;" + localize("DWELL DEPTH") // 0 to disable
  );
}

function onTapping(cycle) {
  writeBlock("CYCL DEF 207 " + localize("RIGID TAPPING NEW") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q239=" + pitchFormat.format((tool.type == TOOL_TAP_LEFT_HAND ? -1 : 1) * tool.threadPitch) + " ;" + localize("THREAD PITCH") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE")
  );
}

function onTappingWithChipBreaking(cycle) {
  writeBlock("CYCL DEF 209 " + localize("TAPPING W/ CHIP BRKG") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q239=" + pitchFormat.format((tool.type == TOOL_TAP_LEFT_HAND ? -1 : 1) * tool.threadPitch) + " ;" + localize("THREAD PITCH") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q257=" + xyzFormat.format(cycle.incrementalDepth) + " ;" + localize("DEPTH FOR CHIP BRKNG") + " ~" + EOL
    + "  Q256=" + xyzFormat.format((cycle.chipBreakDistance != undefined) ? cycle.chipBreakDistance : machineParameters.chipBreakingDistance) + " ;" + localize("DIST. FOR CHIP BRKNG") + " ~" + EOL
    + "  Q336=" + angleFormat.format(0) + " ;" + localize("ANGLE OF SPINDLE")
  );
}

function onReaming(cycle) {
  writeBlock("CYCL DEF 201 " + localize("REAMING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM") + " ~" + EOL
    + "  Q208=" + feedFormat.format(cycle.retractFeedrate) + " ;" + localize("RETRACTION FEED TIME") + " ~" + EOL // retract at reaming feed rate
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE")
  );
}

function onStopBoring(cycle) {
  writeBlock("CYCL DEF 202 " + localize("BORING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM") + " ~" + EOL
    + "  Q208=" + "MAX" + " ;" + localize("RETRACTION FEED RATE") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q214=" + 0 + " ;" + localize("DISENGAGING DIRECTION") + " ~" + EOL
    + "  Q336=" + angleFormat.format(0) + " ;" + localize("ANGLE OF SPINDLE")
  );
}

/** Returns the best discrete disengagement direction for the specified direction. */
function getDisengagementDirection(direction) {
  switch (getQuadrant(direction + 45 * Math.PI / 180)) {
  case 0:
    return 3;
  case 1:
    return 4;
  case 2:
    return 1;
  case 3:
    return 2;
  }
  error(localize("Invalid disengagement direction."));
  return 3;
}

function onFineBoring(cycle) {
  // we do not support cycle.shift

  writeBlock("CYCL DEF 202 " + localize("BORING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM") + " ~" + EOL
    + "  Q208=" + "MAX" + " ;" + localize("RETRACTION FEED TIME") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q214=" + getDisengagementDirection(cycle.shiftDirection) + " ;" + localize("DISENGAGING DIRECTION") + " ~" + EOL
    + "  Q336=" + angleFormat.format(cycle.compensatedShiftOrientation) + " ;" + localize("ANGLE OF SPINDLE")
  );
}

function onBackBoring(cycle) {
  writeBlock("CYCL DEF 204 " + localize("BACK BORING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q249=" + xyzFormat.format(cycle.backBoreDistance) + " ;" + localize("DEPTH REDUCTION") + " ~" + EOL
    + "  Q250=" + xyzFormat.format(cycle.depth) + " ;" + localize("MATERIAL THICKNESS") + " ~" + EOL
    + "  Q251=" + xyzFormat.format(cycle.shift) + " ;" + localize("OFF-CENTER DISTANCE") + " ~" + EOL
    + "  Q252=" + xyzFormat.format(0) + " ;" + localize("TOOL EDGE HEIGHT") + " ~" + EOL
    + "  Q253=" + "MAX" + " ;" + localize("F PRE-POSITIONING") + " ~" + EOL
    + "  Q254=" + feedFormat.format(cycle.feedrate) + " ;" + localize("F COUNTERBORING") + " ~" + EOL
    + "  Q255=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q214=" + getDisengagementDirection(cycle.shiftDirection) + " ;" + localize("DISENGAGING DIRECTION") + " ~" + EOL
    + "  Q336=" + angleFormat.format(cycle.compensatedShiftOrientation) + " ;" + localize("ANGLE OF SPINDLE")
  );
}

function onBoring(cycle) {
  writeBlock("CYCL DEF 202 " + localize("BORING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q211=" + secFormat.format(cycle.dwell) + " ;" + localize("DWELL AT BOTTOM") + " ~" + EOL
    + "  Q208=" + feedFormat.format(cycle.retractFeedrate) + " ;" + localize("RETRACTION FEED RATE") + " ~" + EOL // retract at feed
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q214=" + 0 + " ;" + localize("DISENGAGING DIRECTION") + " ~" + EOL
    + "  Q336=" + angleFormat.format(0) + " ;" + localize("ANGLE OF SPINDLE")
  );
}

function onBoreMilling(cycle) {
  writeBlock("CYCL DEF 208 " + localize("BORE MILLING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q334=" + pitchFormat.format(cycle.pitch) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q335=" + xyzFormat.format(cycle.diameter) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
    + "  Q342=" + xyzFormat.format(tool.diameter) + " ;" + localize("ROUGHING DIAMETER")
  );
}

function onThreadMilling(cycle) {
  cycle.numberOfThreads = 1;
  writeBlock("CYCL DEF 262 " + localize("THREAD MILLING") + " ~" + EOL
    + "  Q335=" + xyzFormat.format(cycle.diameter) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
    // + for right-hand and - for left-hand
    + "  Q239=" + pitchFormat.format(cycle.threading == "right" ? cycle.pitch : -cycle.pitch) + " ;" + localize("PITCH") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("THREAD DEPTH") + " ~" + EOL
    // 0 for threads over entire depth
    + "  Q355=" + xyzFormat.format(cycle.numberOfThreads) + " ;" + localize("THREADS PER STEP") + " ~" + EOL
    + "  Q253=" + feedFormat.format(cycle.feedrate) + " ;" + localize("F PRE-POSITIONING") + " ~" + EOL
    + "  Q351=" + xyzFormat.format(cycle.direction == "climb" ? 1 : -1) + " ;" + localize("CLIMB OR UP-CUT") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q207=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR MILLING")
  );
}

function onCircularPocketMilling(cycle) {
  if (tool.taperAngle > 0) {
    error(localize("Circular pocket milling is not supported for taper tools."));
    return;
  }

  // do NOT use with undercutting - doesnt move to the center before retracting
  writeBlock("CYCL DEF 252 " + localize("CIRCULAR POCKET") + " ~" + EOL
    + "  Q215=1 ;" + localize("MACHINE OPERATION") + " ~" + EOL
    + "  Q223=" + xyzFormat.format(cycle.diameter) + " ;" + localize("CIRCLE DIAMETER") + " ~" + EOL
    + "  Q368=" + xyzFormat.format(0) + " ;" + localize("FINISHING ALLOWANCE FOR SIDE") + " ~" + EOL
    + "  Q207=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR MILLING") + " ~" + EOL
    + "  Q351=" + xyzFormat.format(cycle.direction == "climb" ? 1 : -1) + " ;" + localize("CLIMB OR UP-CUT") + " ~" + EOL
    + "  Q201=" + xyzFormat.format(-cycle.depth) + " ;" + localize("DEPTH") + " ~" + EOL
    + "  Q202=" + xyzFormat.format(cycle.incrementalDepth) + " ;" + localize("INFEED DEPTH") + " ~" + EOL
    + "  Q369=" + xyzFormat.format(0) + " ;" + localize("FINISHING ALLOWANCE FOR FLOOR") + " ~" + EOL
    + "  Q206=" + feedFormat.format(cycle.plungeFeedrate) + " ;" + localize("FEED RATE FOR PLUNGING") + " ~" + EOL
    + "  Q338=0 ;" + localize("INFEED FOR FINISHING") + " ~" + EOL
    + "  Q200=" + xyzFormat.format(cycle.retract - cycle.stock) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
    + "  Q203=" + xyzFormat.format(cycle.stock) + " ;" + localize("SURFACE COORDINATE") + " ~" + EOL
    + "  Q204=" + xyzFormat.format(cycle.clearance - cycle.stock) + " ;" + localize("2ND SET-UP CLEARANCE") + " ~" + EOL
    + "  Q370=" + ratioFormat.format(cycle.stepover / (tool.diameter / 2)) + " ;" + localize("TOOL PATH OVERLAP") + " ~" + EOL
    + "  Q366=" + "0" + " ;" + localize("PLUNGING") + " ~" + EOL
    + "  Q385=" + feedFormat.format(cycle.feedrate) + " ;" + localize("FEED RATE FOR FINISHING")
  );
}

function setCyclePosition(_position) {
  zOutput.format(_position);
}

var expandCurrentCycle = false;

function onCycle() {
  if (cycleType == "inspect") {
    return;
  }
  if (!isSameDirection(getRotation().forward, new Vector(0, 0, 1))) {
    expandCurrentCycle = getProperty("expandCycles");
    if (!expandCurrentCycle) {
      cycleNotSupported();
    }
    return;
  }
  if (isProbeOperation()) {
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  expandCurrentCycle = false;

  if (cycle.clearance != undefined) {
    if (getCurrentPosition().z < cycle.clearance) {
      writeBlock("L" + zOutput.format(cycle.clearance) + radiusCompensationTable.lookup(radiusCompensation) + " FMAX");
      setCurrentPositionZ(cycle.clearance);
    }
  }

  switch (cycleType) {
  case "drilling": // G81 style
    onDrilling(cycle);
    break;
  case "counter-boring":
    onCounterBoring(cycle);
    break;
  case "chip-breaking":
    onChipBreaking(cycle);
    break;
  case "deep-drilling":
    onDeepDrilling(cycle);
    break;
  case "gun-drilling":
    onGunDrilling(cycle);
    break;
  case "tapping":
  case "left-tapping":
  case "right-tapping":
    onTapping(cycle);
    break;
  case "tapping-with-chip-breaking":
  case "left-tapping-with-chip-breaking":
  case "right-tapping-with-chip-breaking":
    onTappingWithChipBreaking(cycle);
    break;
  case "reaming":
    onReaming(cycle);
    break;
  case "stop-boring":
    onStopBoring(cycle);
    break;
  case "fine-boring":
    onFineBoring(cycle);
    break;
  case "back-boring":
    onBackBoring(cycle);
    break;
  case "boring":
    onBoring(cycle);
    break;
  case "bore-milling":
    if (cycle.numberOfSteps != undefined && cycle.numberOfSteps > 1) {
      expandCurrentCycle = getProperty("expandCycles");
      if (!expandCurrentCycle) {
        cycleNotSupported();
      }
    } else {
      onBoreMilling(cycle);
    }
    break;
  case "thread-milling":
    if (cycle.numberOfSteps != undefined && cycle.numberOfSteps > 1) {
      expandCurrentCycle = getProperty("expandCycles");
      if (!expandCurrentCycle) {
        cycleNotSupported();
      }
    } else {
      onThreadMilling(cycle);
    }
    break;
  case "circular-pocket-milling":
    onCircularPocketMilling(cycle);
    break;
  default:
    expandCurrentCycle = getProperty("expandCycles");
    if (!expandCurrentCycle) {
      cycleNotSupported();
    }
  }
}

/** Convert approach to sign. */
function approach(value) {
  validate((value == "positive") || (value == "negative"), "Invalid approach.");
  return (value == "positive") ? 1 : -1;
}

function getCompensationAxis() {
  var axes = [machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW()];
  for (var i = 0; i < axes.length; ++i) {
    if (axes[i].isEnabled() && isSameDirection((axes[i].getAxis()).getAbsolute(), machineConfiguration.getSpindleAxis()) && axes[i].isTable()) {
      return (axes[i].getCoordinate() + 4);
    }
  }
  return -1;
}

function onCyclePoint(x, y, z) {
  if (cycleType == "inspect") {
    if (typeof inspectionCycleInspect == "function") {
      inspectionCycleInspect(cycle, x, y, z);
      return;
    } else {
      cycleNotSupported();
    }
  }

  if (isProbeOperation()) {
    var probeGeometry = hasParameter("operation-strategy") && (getParameter("operation-strategy") == "probe_geometry");
    if (!isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      if (!allowIndexingWCSProbing && currentSection.strategy == "probe") {
        error(localize("Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."));
        return;
      }
    }

    var Q330 = "  Q330=+0" + " ;" + localize("TOOL");
    if (cycle.updateToolWear == 1) {
      if (getProperty("toolAsName")) {
        if (cycle.toolDescription.toUpperCase() == "") {
          warning(localize("The description of the tool to be updated is empty. It will not be updated."));
        } else {
          Q330 = "  QS330=" + "\"" + (cycle.toolDescription.toUpperCase()) + "\"" + " ;" + localize("TOOL NAME");
        }
      } else {
        Q330 = "  Q330=" + xyzFormat.format(cycle.toolWearNumber) + " ;" + localize("TOOL NUMBER");
      }
    }

    var tolerancePosition = cycle.hasPositionalTolerance ? cycle.tolerancePosition : 0;
    switch (cycleType) {
    case "probing-x":
      if (probeGeometry) {
        writeBlock("TCH PROBE 427 " + localize("MEASURE COORDINATE") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1))  + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2) + tolerancePosition) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q289=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2) - tolerancePosition) +  " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR427.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 419 " + localize("DATUM IN ONE AXIS") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER")
        );
      }
      break;
    case "probing-y":
      if (probeGeometry) {
        writeBlock("TCH PROBE 427 " + localize("MEASURE COORDINATE") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1))  + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2) + tolerancePosition) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q289=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2) - tolerancePosition) +  " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR427.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 419 " + localize("DATUM IN ONE AXIS") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER")
        );
      }
      break;
    case "probing-z":
      if (probeGeometry) {
        writeBlock("TCH PROBE 427 " + localize("MEASURE COORDINATE") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(3) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1))  + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(z - cycle.depth + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q289=" + xyzFormat.format(z - cycle.depth - cycle.toleranceSize) +  " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR427.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 417 " + localize("DATUM IN TS AXIS") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q294=" + xyzFormat.format(z - cycle.depth) + " ;" + localize("1ST POINT 3RD AXIS") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(z - cycle.depth) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER")
        );
      }
      break;
    case "probing-x-channel":
    case "probing-x-channel-with-island":
      if (probeGeometry) {
        writeBlock("TCH PROBE 425 " + localize("MEASURE INSIDE WIDTH") + " ~" + EOL
          + "  Q328=" + xyzFormat.format(x) + " ;" + localize("STARTNG PNT 1ST AXIS") + " ~" + EOL
          + "  Q329=" + xyzFormat.format(y) + " ;" + localize("STARTNG PNT 2ND AXIS") + " ~" + EOL
          + "  Q310=" + xyzFormat.format(0) + " ;" + localize("OFFS. 2ND MEASUREMNT") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL LENGTH") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR425.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 408 " + localize("SLOT CENTER REF PT") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("SLOT WIDTH") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance ? cycle.probeClearance : 0) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(cycleType == "probing-x-channel" ? 0 : 1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q405=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
    case "probing-y-channel":
    case "probing-y-channel-with-island":
      if (probeGeometry) {
        writeBlock("TCH PROBE 425 " + localize("MEASURE INSIDE WIDTH") + " ~" + EOL
          + "  Q328=" + xyzFormat.format(x) + " ;" + localize("STARTNG PNT 1ST AXIS") + " ~" + EOL
          + "  Q329=" + xyzFormat.format(y) + " ;" + localize("STARTNG PNT 2ND AXIS") + " ~" + EOL
          + "  Q310=" + xyzFormat.format(0) + " ;" + localize("OFFS. 2ND MEASUREMNT") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL LENGTH") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR425.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 408 " + localize("SLOT CENTER REF PT") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("SLOT WIDTH") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance ? cycle.probeClearance : 0) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(cycleType == "probing-y-channel" ? 0 : 1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q405=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
    case "probing-x-wall":
      if (probeGeometry) {
        var firstPoint = x + (cycle.width1 / 2) + cycle.probeClearance + (tool.diameter / 2);
        var secondPoint = x - (cycle.width1 / 2) - cycle.probeClearance - (tool.diameter / 2);
        writeBlock("TCH PROBE 426 " + localize("MEASURE RIDGE WIDTH") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(Math.max(firstPoint, secondPoint))  + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q265=" + xyzFormat.format(Math.min(firstPoint, secondPoint))  + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
          + "  Q266=" + xyzFormat.format(y) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL LENGTH") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q289=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR426.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 409 " + localize("RIDGE CENTER REF PT") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("RIDGE WIDTH") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q405=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
    case "probing-y-wall":
      if (probeGeometry) {
        var firstPoint = y + (cycle.width1 / 2) + cycle.probeClearance + (tool.diameter / 2);
        var secondPoint = y - (cycle.width1 / 2) - cycle.probeClearance - (tool.diameter / 2);
        writeBlock("TCH PROBE 426 " + localize("MEASURE RIDGE WIDTH") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x)  + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(Math.max(firstPoint, secondPoint)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q265=" + xyzFormat.format(x)  + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
          + "  Q266=" + xyzFormat.format(Math.min(firstPoint, secondPoint)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL LENGTH") + " ~" + EOL
          + "  Q288=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q289=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR426.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 409 " + localize("RIDGE CENTER REF PT") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q311=" + xyzFormat.format(cycle.width1) + " ;" + localize("RIDGE WIDTH") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q405=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
      /*
    case "probing-xy-inner-corner":
      // Heidenhain needs 2 points per surface for inner and outer corner probing
      var spacing = cycle.probeSpacing ? cycle.probeSpacing : tool.diameter * 0.2;
      writeBlock("TCH PROBE 415 " + localize("DATUM INSIDE CORNER") + " ~" + EOL
        + "  Q263=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter/2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
        + "  Q264=" + xyzFormat.format(y + approach(cycle.approach2) * (cycle.probeClearance + tool.diameter/2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
        + "  Q326=" + xyzFormat.format(spacing) + " ;" + localize("SPACING IN 1ST AXIS") + " ~" + EOL
        + "  Q327=" + xyzFormat.format(spacing) + " ;" + localize("SPACING IN 2ND AXIS") + " ~" + EOL
      );
      break;
*/
    case "probing-xy-circular-hole":
    case "probing-xy-circular-hole-with-island":
      if (probeGeometry) {
        writeBlock("TCH PROBE 421 " + localize("MEASURE HOLE") + " ~" + EOL
          + "  Q273=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q274=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q262=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
          + "  Q325=" + xyzFormat.format(0) + " ;" + localize("STARTING ANGLE") + " ~" + EOL
          + "  Q247=" + xyzFormat.format(90) + " ;" + localize("STEPPING ANGLE") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q275=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q276=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + conditional(cycle.hasPositionalTolerance, "  Q279=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 1ST CENTER") + " ~" + EOL)
          + conditional(cycle.hasPositionalTolerance, "  Q280=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 2ND CENTER") + " ~" + EOL)
          + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR421.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 412 " + localize("DATUM INSIDE CIRCLE") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q262=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
          + "  Q325=" + xyzFormat.format(0) + " ;" + localize("STARTING ANGLE") + " ~" + EOL
          + "  Q247=" + xyzFormat.format(90) + " ;" + localize("STEPPING ANGLE") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance ? cycle.probeClearance : 0) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q331=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q332=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q423=" + xyzFormat.format(4) + " ;" + localize("NO. OF MEAS. POINTS") + " ~" + EOL
          + "  Q365=" + xyzFormat.format(1) + " ;" + localize("TYPE OF TRAVERSE")
        );
      }
      break;
    case "probing-xy-rectangular-hole":
    case "probing-xy-rectangular-hole-with-island":
      if (probeGeometry) {
        writeBlock("TCH PROBE 423 " + localize("MEAS. RECTAN. INSIDE") + " ~" + EOL
          + "  Q273=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q274=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q282=" + xyzFormat.format(cycle.width1) + " ;" + localize("1ST SIDE LENGTH") + " ~" + EOL
          + "  Q283=" + xyzFormat.format(cycle.width2) + " ;" + localize("2ND SIDE LENGTH") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q284=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAX. LIMIT 1ST SIDE") + " ~" + EOL
          + "  Q285=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MIN. LIMIT 1ST SIDE") + " ~" + EOL
          + "  Q286=" + xyzFormat.format(cycle.width2 + cycle.toleranceSize) + " ;" + localize("MAX. LIMIT 2ND SIDE") + " ~" + EOL
          + "  Q287=" + xyzFormat.format(cycle.width2 - cycle.toleranceSize) + " ;" + localize("MIN. LIMIT 2ND SIDE") + " ~" + EOL
          + conditional(cycle.hasPositionalTolerance, "  Q279=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 1ST CENTER") + " ~" + EOL)
          + conditional(cycle.hasPositionalTolerance, "  Q280=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 2ND CENTER") + " ~" + EOL)
          + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR423.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 410 " + localize("DATUM INSIDE RECTAN.") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q323=" + xyzFormat.format(cycle.width1) + " ;" + localize("FIRST SIDE LENGTH") + " ~" + EOL
          + "  Q324=" + xyzFormat.format(cycle.width2) + " ;" + localize("2ND SIDE LENGTH") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance ? cycle.probeClearance : 0) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(cycleType == "probing-xy-rectangular-hole" ? 0 : 1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q331=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q332=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
    case "probing-xy-circular-boss":
      if (probeGeometry) {
        writeBlock("TCH PROBE 422 " + localize("MEAS. CIRCLE OUTSIDE") + " ~" + EOL
          + "  Q273=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q274=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q262=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
          + "  Q325=" + xyzFormat.format(0) + " ;" + localize("STARTING ANGLE") + " ~" + EOL
          + "  Q247=" + xyzFormat.format(90) + " ;" + localize("STEPPING ANGLE") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q277=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAXIMUM DIMENSION") + " ~" + EOL
          + "  Q278=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MINIMUM DIMENSION") + " ~" + EOL
          + conditional(cycle.hasPositionalTolerance, "  Q279=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 1ST CENTER") + " ~" + EOL)
          + conditional(cycle.hasPositionalTolerance, "  Q280=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 2ND CENTER") + " ~" + EOL)
          + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR422.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 413 " + localize("DATUM OUTSIDE CIRCLE") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q262=" + xyzFormat.format(cycle.width1) + " ;" + localize("NOMINAL DIAMETER") + " ~" + EOL
          + "  Q325=" + xyzFormat.format(0) + " ;" + localize("STARTING ANGLE") + " ~" + EOL
          + "  Q247=" + xyzFormat.format(90) + " ;" + localize("STEPPING ANGLE") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q331=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q332=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q423=" + xyzFormat.format(4) + " ;" + localize("NO. OF MEAS. POINTS") + " ~" + EOL
          + "  Q365=" + xyzFormat.format(1) + " ;" + localize("TYPE OF TRAVERSE")
        );
      }
      break;
    case "probing-xy-rectangular-boss":
      if (probeGeometry) {
        writeBlock("TCH PROBE 424 " + localize("MEAS. RECTAN. OUTS.") + " ~" + EOL
          + "  Q273=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q274=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q282=" + xyzFormat.format(cycle.width1) + " ;" + localize("1ST SIDE LENGTH") + " ~" + EOL
          + "  Q283=" + xyzFormat.format(cycle.width2) + " ;" + localize("2ND SIDE LENGTH") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q284=" + xyzFormat.format(cycle.width1 + cycle.toleranceSize) + " ;" + localize("MAX. LIMIT 1ST SIDE") + " ~" + EOL
          + "  Q285=" + xyzFormat.format(cycle.width1 - cycle.toleranceSize) + " ;" + localize("MIN. LIMIT 1ST SIDE") + " ~" + EOL
          + "  Q286=" + xyzFormat.format(cycle.width2 + cycle.toleranceSize) + " ;" + localize("MAX. LIMIT 2ND SIDE") + " ~" + EOL
          + "  Q287=" + xyzFormat.format(cycle.width2 - cycle.toleranceSize) + " ;" + localize("MIN. LIMIT 2ND SIDE") + " ~" + EOL
          + conditional(cycle.hasPositionalTolerance, "  Q279=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 1ST CENTER") + " ~" + EOL)
          + conditional(cycle.hasPositionalTolerance, "  Q280=" + xyzFormat.format(cycle.tolerancePosition) + " ;" + localize("TOLERANCE 2ND CENTER") + " ~" + EOL)
          + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG") + " ~" + EOL
          + "  Q309=" + xyzFormat.format(cycle.wrongSizeAction == "stop-message" || cycle.outOfPositionAction == "stop-message" ? 1 : 0) + " ;" + localize("PGM-STOP IF ERROR") + " ~" + EOL
          + Q330
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR424.TXT" : undefined;
      } else {
        writeBlock("TCH PROBE 411 " + localize("DATUM OUTS. RECTAN.") + " ~" + EOL
          + "  Q321=" + xyzFormat.format(x) + " ;" + localize("CENTER IN 1ST AXIS") + " ~" + EOL
          + "  Q322=" + xyzFormat.format(y) + " ;" + localize("CENTER IN 2ND AXIS") + " ~" + EOL
          + "  Q323=" + xyzFormat.format(cycle.width1) + " ;" + localize("FIRST SIDE LENGTH") + " ~" + EOL
          + "  Q324=" + xyzFormat.format(cycle.width2) + " ;" + localize("2ND SIDE LENGTH") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
          + "  Q331=" + xyzFormat.format(x) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q332=" + xyzFormat.format(y) + " ;" + localize("DATUM") + " ~" + EOL
          + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
          + "  Q381=" + xyzFormat.format(0) + " ;" + localize("PROBE IN TS AXIS") + " ~" + EOL
          + "  Q382=" + xyzFormat.format(0) + " ;" + localize("1ST CO. FOR TS AXIS") + " ~" + EOL
          + "  Q383=" + xyzFormat.format(0) + " ;" + localize("2ND CO. FOR TS AXIS") + " ~" + EOL
          + "  Q384=" + xyzFormat.format(0) + " ;" + localize("3RD CO. FOR TS AXIS") + " ~" + EOL
          + "  Q333=" + xyzFormat.format(0) + " ;" + localize("DATUM")
        );
      }
      break;
    case "probing-x-plane-angle":
      if (probeGeometry) {
        writeBlock("TCH PROBE 420 " + localize("MEASURE ANGLE") + " ~" + EOL
          + "  Q263=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
          + "  Q264=" + xyzFormat.format(y + (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
          + "  Q265=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
          + "  Q266=" + xyzFormat.format(y - (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
          + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
          + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
          + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
          + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
          + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
          + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
          + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG")
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR420.TXT" : undefined;
      } else {
        if (getCompensationAxis() < 0) {
          writeBlock("TCH PROBE 400 " + localize("BASIC ROTATION") + " ~" + EOL
            + "  Q263=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
            + "  Q264=" + xyzFormat.format(y + (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
            + "  Q265=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
            + "  Q266=" + xyzFormat.format(y - (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
            + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
            + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
            + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
            + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
            + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
            + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
            + "  Q307=" + xyzFormat.format(0) + " ;" + localize("PRESET ROTATION ANG.") + " ~" + EOL
            + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE")
          );
        } else {
          writeBlock("TCH PROBE 403 " + localize("ROT IN ROTARY AXIS") + " ~" + EOL
            + "  Q263=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
            + "  Q264=" + xyzFormat.format(y + (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
            + "  Q265=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
            + "  Q266=" + xyzFormat.format(y - (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
            + "  Q272=" + xyzFormat.format(1) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
            + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
            + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
            + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
            + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
            + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
            + "  Q312=" + xyzFormat.format(getCompensationAxis()) + " ;" + localize("COMPENSATION AXIS") + " ~" + EOL
            + "  Q337=" + xyzFormat.format(1) + " ;" + localize("SET TO ZERO") + " ~" + EOL
            + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
            + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
            + "  Q380=" + xyzFormat.format(0) + " ;" + localize("REFERENCE ANGLE")
          );
        }
      }
      break;
    case "probing-y-plane-angle":
      if (probeGeometry) {
        writeBlock("TCH PROBE 420 " + localize("MEASURE ANGLE") + " ~" + EOL
            + "  Q263=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
            + "  Q264=" + xyzFormat.format(y + (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
            + "  Q265=" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
            + "  Q266=" + xyzFormat.format(y - (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
            + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
            + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
            + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
            + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
            + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
            + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
            + "  Q281=" + xyzFormat.format(cycle.printResults == 1 ? 1 : 0) + " ;" + localize("MEASURING LOG")
        );
        logFileName = (cycle.printResults > 0) ? "TCHPR420.TXT" : undefined;
      } else {
        if (getCompensationAxis() < 0) {
          writeBlock("TCH PROBE 400 " + localize("BASIC ROTATION") + " ~" + EOL
              + "  Q263=" + xyzFormat.format(x - (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
              + "  Q264=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
              + "  Q265=" + xyzFormat.format(x + (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
              + "  Q266=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
              + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
              + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
              + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
              + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
              + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
              + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
              + "  Q307=" + xyzFormat.format(0) + " ;" + localize("PRESET ROTATION ANG.") + " ~" + EOL
              + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE")
          );
        } else {
          writeBlock("TCH PROBE 403 " + localize("ROT IN ROTARY AXIS") + " ~" + EOL
              + "  Q263=" + xyzFormat.format(x - (cycle.probeSpacing / 2)) + " ;" + localize("1ST POINT 1ST AXIS") + " ~" + EOL
              + "  Q264=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("1ST POINT 2ND AXIS") + " ~" + EOL
              + "  Q265=" + xyzFormat.format(x + (cycle.probeSpacing / 2)) + " ;" + localize("2ND POINT 1ST AXIS") + " ~" + EOL
              + "  Q266=" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)) + " ;" + localize("2ND POINT 2ND AXIS") + " ~" + EOL
              + "  Q272=" + xyzFormat.format(2) + " ;" + localize("MEASURING AXIS") + " ~" + EOL
              + "  Q267=" + xyzFormat.format(approach(cycle.approach1)) + " ;" + localize("TRAVERSE DIRECTION") + " ~" + EOL
              + "  Q261=" + xyzFormat.format((z + tool.diameter / 2) - cycle.depth) + " ;" + localize("MEASURING HEIGHT") + " ~" + EOL
              + "  Q320=" + xyzFormat.format(cycle.probeClearance) + " ;" + localize("SET-UP CLEARANCE") + " ~" + EOL
              + "  Q260=" + xyzFormat.format(cycle.stock) + " ;" + localize("CLEARANCE HEIGHT") + " ~" + EOL
              + "  Q301=" + xyzFormat.format(1) + " ;" + localize("MOVE TO CLEARANCE") + " ~" + EOL
              + "  Q312=" + xyzFormat.format(getCompensationAxis()) + " ;" + localize("COMPENSATION AXIS") + " ~" + EOL
              + "  Q337=" + xyzFormat.format(1) + " ;" + localize("SET TO ZERO") + " ~" + EOL
              + "  Q305=" + xyzFormat.format(probeOutputWorkOffset) + " ;" + localize("NUMBER IN TABLE") + " ~" + EOL
              + "  Q303=" + xyzFormat.format(1) + " ;" + localize("MEAS. VALUE TRANSFER") + " ~" + EOL
              + "  Q380=" + xyzFormat.format(0) + " ;" + localize("REFERENCE ANGLE")
          );
        }
      }
      break;
    default:
      cycleNotSupported();
    }
    return;
  }

  if (!expandCurrentCycle) {
    // execute current cycle after this positioning block
    /*
    if (cycleType == "circular-pocket-milling") {
      if (isFirstCyclePoint()) {
        onCircularPocketFinishMilling(x, y, cycle);
        writeBlock("CYCL CALL");
      } else {
        writeBlock("FN 0: Q216 = " + xyzFormat.format(x));
        writeBlock("FN 0: Q217 = " + xyzFormat.format(y));
        writeBlock("CYCL CALL");
        xOutput.reset();
        yOutput.reset();
      }
    } else {
      writeBlock("L" + xOutput.format(x) + yOutput.format(y) + " FMAX " + mFormat.format(99));
    }
*/

    // place cycle operation in subprogram
    if (cycleSubprogramIsActive) {
      if (isFirstCyclePoint()) {
        // call subprogram
        writeBlock("CALL LBL " + currentSubprogram);
        subprogramStart(new Vector(x, y, z), new Vector(0, 0, 0), false);
      }
    }

    writeBlock("L" + xOutput.format(x) + yOutput.format(y) + " FMAX " + mFormat.format(99));
    if (incrementalMode) { // set current position to clearance height
      setCyclePosition(cycle.clearance);
    }
  } else {
    expandCyclePoint(x, y, z);
    cycleSubprogramIsActive = false;
  }
}

function onCycleEnd() {
  if (cycleSubprogramIsActive) {
    subprogramEnd();
    cycleSubprogramIsActive = false;
  }

  zOutput.reset();
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(x, y, z) {
  var xyz = xOutput.format(x) + yOutput.format(y) + zOutput.format(z);
  if (xyz) {
    pendingRadiusCompensation = -1;
    writeBlock("L" + xyz + radiusCompensationTable.lookup(radiusCompensation) + " FMAX");
  }
  forceFeed();
}

function onLinear(x, y, z, feed) {
  var xyz = xOutput.format(x) + yOutput.format(y) + zOutput.format(z);
  var f = getFeed(feed);
  if (xyz) {
    pendingRadiusCompensation = -1;
    writeBlock("L" + xyz + radiusCompensationTable.lookup(radiusCompensation) + f);
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      pendingRadiusCompensation = -1;
      writeBlock("L" + radiusCompensationTable.lookup(radiusCompensation) + f);
    }
  }
}

function onRapid5D(x, y, z, a, b, c) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }

  if (currentSection.isOptimizedForMachine()) {
    var xyzabc = xOutput.format(x) + yOutput.format(y) + zOutput.format(z) + aOutput.format(a) + bOutput.format(b) + cOutput.format(c);
    if (xyzabc) {
      writeBlock("L" + xyzabc + radiusCompensationTable.lookup(radiusCompensation) + " FMAX");
    }
  } else {
    forceXYZ(); // required
    var pt = xOutput.format(x) + yOutput.format(y) + zOutput.format(z) + txOutput.format(a) + tyOutput.format(b) + tzOutput.format(c);
    if (pt) {
      pendingRadiusCompensation = -1;
      writeBlock("LN" + pt + radiusCompensationTable.lookup(radiusCompensation) + " FMAX");
    }
  }
  forceFeed(); // force feed on next line
}

function onLinear5D(x, y, z, a, b, c, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }

  if (currentSection.isOptimizedForMachine()) {
    var xyzabc = xOutput.format(x) + yOutput.format(y) + zOutput.format(z) + aOutput.format(a) + bOutput.format(b) + cOutput.format(c);
    var f = getFeed(feed);
    if (xyzabc) {
      writeBlock("L" + xyzabc + radiusCompensationTable.lookup(radiusCompensation) + f);
    } else if (f) {
      if (getNextRecord().isMotion()) { // try not to output feed without motion
        forceFeed(); // force feed on next line
      } else {
        pendingRadiusCompensation = -1;
        writeBlock("L" + radiusCompensationTable.lookup(radiusCompensation) + f);
      }
    }
  } else {
    forceXYZ(); // required
    var pt = xOutput.format(x) + yOutput.format(y) + zOutput.format(z) + txOutput.format(a) + tyOutput.format(b) + tzOutput.format(c);
    var f = getFeed(feed);
    if (pt) {
      pendingRadiusCompensation = -1;
      writeBlock("LN" + pt + radiusCompensationTable.lookup(radiusCompensation) + f);
    } else if (f) {
      if (getNextRecord().isMotion()) { // try not to output feed without motion
        forceFeed(); // force feed on next line
      } else {
        pendingRadiusCompensation = -1;
        writeBlock("LN" + radiusCompensationTable.lookup(radiusCompensation) + f);
      }
    }
  }
}

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();
  switch (getCircularPlane()) {
  case PLANE_XY:
    if (incrementalMode) {
      writeBlock("CC IX" + xyzFormat.format(cx - start.x) + " IY" + xyzFormat.format(cy - start.y));
    } else {
      writeBlock("CC X" + xyzFormat.format(cx) + " Y" + xyzFormat.format(cy));
    }
    break;
  case PLANE_ZX:
    if (isHelical()) {
      var t = tolerance;
      if ((t == 0) && hasParameter("operation:tolerance")) {
        t = getParameter("operation:tolerance");
      }
      linearize(t);
      return;
    }
    if (incrementalMode) {
      writeBlock("CC IX" + xyzFormat.format(cx - start.x) + " IZ" + xyzFormat.format(cz - start.z));
    } else {
      writeBlock("CC X" + xyzFormat.format(cx) + " Z" + xyzFormat.format(cz));
    }
    break;
  case PLANE_YZ:
    if (isHelical()) {
      var t = tolerance;
      if ((t == 0) && hasParameter("operation:tolerance")) {
        t = getParameter("operation:tolerance");
      }
      linearize(t);
      return;
    }
    if (incrementalMode) {
      writeBlock("CC IY" + xyzFormat.format(cy - start.y) + " IZ" + xyzFormat.format(cz - start.z));
    } else {
      writeBlock("CC Y" + xyzFormat.format(cy) + " Z" + xyzFormat.format(cz));
    }
    break;
  default:
    var t = tolerance;
    if ((t == 0) && hasParameter("operation:tolerance")) {
      t = getParameter("operation:tolerance");
    }
    linearize(t);
    return;
  }

  if (false && !isHelical() && (Math.abs(getCircularSweep()) <= 2 * Math.PI * 0.9)) { // use IPA to avoid radius compensation errors
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(
        "C" + xOutput.format(x) + yOutput.format(y) +
        (clockwise ? " DR-" : " DR+") +
        radiusCompensationTable.lookup(radiusCompensation) +
        getFeed(feed)
      );
      break;
    case PLANE_ZX:
      writeBlock(
        "C" + xOutput.format(x) + zOutput.format(z) +
        (clockwise ? " DR-" : " DR+") +
        radiusCompensationTable.lookup(radiusCompensation) +
        getFeed(feed)
      );
      break;
    case PLANE_YZ:
      writeBlock(
        "C" + yOutput.format(y) + zOutput.format(z) +
        (clockwise ? " DR-" : " DR+") +
        radiusCompensationTable.lookup(radiusCompensation) +
        getFeed(feed)
      );
      break;
    default:
      var t = tolerance;
      if ((t == 0) && hasParameter("operation:tolerance")) {
        t = getParameter("operation:tolerance");
      }
      linearize(t);
    }
    return;
  }

  if (isHelical()) {
    if (getCircularPlane() == PLANE_XY) {
      // IPA must have same sign as DR
      var sweep = (clockwise ? -1 : 1) * Math.abs(getCircularSweep());
      var block = "CP IPA" + paFormat.format(sweep) + zOutput.format(z);
      block += clockwise ? " DR-" : " DR+";
      block += /*radiusCompensationTable.lookup(radiusCompensation) +*/ getFeed(feed);
      writeBlock(block);
      xOutput.reset();
      yOutput.reset();
    } else {
      var t = tolerance;
      if ((t == 0) && hasParameter("operation:tolerance")) {
        t = getParameter("operation:tolerance");
      }
      linearize(t);
    }
  } else {
    // IPA must have same sign as DR
    var sweep = (clockwise ? -1 : 1) * Math.abs(getCircularSweep());
    var block = "CP IPA" + paFormat.format(sweep);
    block += clockwise ? " DR-" : " DR+";
    block += /*radiusCompensationTable.lookup(radiusCompensation) +*/ getFeed(feed);
    writeBlock(block);

    switch (getCircularPlane()) {
    case PLANE_XY:
      xOutput.reset();
      yOutput.reset();
      break;
    case PLANE_ZX:
      xOutput.reset();
      zOutput.reset();
      break;
    case PLANE_YZ:
      yOutput.reset();
      zOutput.reset();
      break;
    default:
      invalidateXYZ();
    }
  }
  if (incrementalMode) {
    xOutput.format(x);
    yOutput.format(y);
    zOutput.format(z);
  }
}

/** Used for gun drilling. */
function getCoolantCode(coolant) {
  forceCoolant = true;
  return getCoolantCodes(coolant, true);
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;
var forceCoolant = false;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant, false);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant, isGunDrilling) {
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the output line
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode && !forceCoolant) {
    return undefined; // coolant is already active
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined) && !forceCoolant) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }
  forceCoolant = false;

  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    if (isGunDrilling) {
      return [m, coolantOff];
    } else {
      return multipleCoolantBlocks; // return the single formatted coolant value
    }
  }
  return undefined;
}

var mapCommand = {
  COMMAND_END                     : 30,
  COMMAND_SPINDLE_CLOCKWISE       : 3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE: 4,
  // COMMAND_START_SPINDLE
  COMMAND_STOP_SPINDLE            : 5
  //COMMAND_ORIENTATE_SPINDLE:19,
  //COMMAND_LOAD_TOOL:6, // do not use
  //COMMAND_COOLANT_ON,
  //COMMAND_COOLANT_OFF,
  //COMMAND_ACTIVATE_SPEED_FEED_SYNCHRONIZATION
  //COMMAND_DEACTIVATE_SPEED_FEED_SYNCHRONIZATION
};

function onCommand(command) {
  switch (command) {
  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_OPTIONAL_STOP:
    writeBlock(mFormat.format(1));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_COOLANT_OFF:
    setCoolant(COOLANT_OFF);
    return;
  case COMMAND_COOLANT_ON:
    setCoolant(COOLANT_FLOOD);
    return;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    writeBlock(mFormat.format(26));
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    writeBlock(mFormat.format(25));
    return;
  case COMMAND_START_CHIP_TRANSPORT:
    // start chip transport in a paused manner
    writeBlock(mFormat.format(21));
    return;
  case COMMAND_STOP_CHIP_TRANSPORT:
    writeBlock(mFormat.format(23));
    return;
  case COMMAND_BREAK_CONTROL:
      // call blum probe program saved in TNC
      writeBlock("CALL PGM TNC:BLUM\\BLUM586");
      return;
    return;
  case COMMAND_TOOL_MEASURE:
          // call blum probe program saved in TNC
      writeBlock("CALL PGM TNC:BLUM\\BLUM583");
    return;
  case COMMAND_PROBE_ON:
    return;
  case COMMAND_PROBE_OFF:
    return;
  }

  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

function onSectionEnd() {
  if (typeof inspectionProcessSectionEnd == "function") {
    inspectionProcessSectionEnd();
  }
  if (true) {
    if (isRedirecting()) {
      if (firstPattern) {
        var finalPosition = getFramePosition(currentSection.getFinalPosition());
        var abc;
        if (currentSection.isMultiAxis() && machineConfiguration.isMultiAxisConfiguration()) {
          abc = currentSection.getFinalToolAxisABC();
        } else {
          abc = currentWorkPlaneABC;
        }
        if (abc == undefined) {
          abc = new Vector(0, 0, 0);
        }
        setAbsoluteMode(finalPosition, abc);
        subprogramEnd();
      }
    }
  }
  if (!isLastSection() && (getNextSection().getTool().coolant != tool.coolant)) {
    setCoolant(COOLANT_OFF);
  }
  if (currentSection.isMultiAxis()) {
    setTCP(false);
    // the code below gets the machine angles from previous operation.  closestABC must also be set to true
    if (currentSection.isOptimizedForMachine()) {
      currentMachineABC = currentSection.getFinalToolAxisABC();
    }
  }
  if (isProbeOperation()) {
    setWCS();

    if (logFileName != undefined) {
      var comment;
      if (hasParameter("operation-comment")) {
        comment = getParameter("operation-comment").replace(" ", "_") + ".TXT";
        writeBlock("");
        writeBlock("FUNCTION FILECOPY " + "\"" + logfilePath + logFileName + "\" TO");
        writeBlock(" " + "\"" + logfilePath + comment + "\"");
        writeBlock("FUNCTION FILEDELETE " + "\"" + logfilePath + logFileName + "\"");
        writeBlock("");
        logFileName = undefined;
      }
    }
  }
  invalidate();
}

/** Output block to do safe retract and/or move to home position. */
function writeRetract() {
  var words = []; // store all retracted axes in an array
  var retractAxes = new Array(false, false, false);
  var method = getProperty("safePositionMethod");
  if (method == "clearanceHeight") {
    if (!is3D()) {
      error(localize("Safe retract option 'Clearance Height' is only supported when all operations are along the setup Z-axis."));
    }
    return;
  }
  validate(arguments.length != 0, "No axis specified for writeRetract().");

  for (i in arguments) {
    retractAxes[arguments[i]] = true;
  }
  if ((retractAxes[0] || retractAxes[1]) && !retracted) { // retract Z first before moving to X/Y home
    error(localize("Retracting in X/Y is not possible without being retracted in Z."));
    return;
  }
  // special conditions
  /*
  if (retractAxes[2]) { // Z doesn't use G53
    method = "G28";
  }
  */

  // define home positions
  var _xHome;
  var _yHome;
  var _zHome;
  if (false && method == "G28") { // always use machine home positions
    _xHome = toPreciseUnit(0, MM);
    _yHome = toPreciseUnit(0, MM);
    _zHome = toPreciseUnit(0, MM);
  } else {
    _xHome = machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : toPreciseUnit(0, MM);
    _yHome = machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : toPreciseUnit(0, MM);
    _zHome = machineConfiguration.getRetractPlane() != 0 ? machineConfiguration.getRetractPlane() : toPreciseUnit(0, MM);
  }
  for (var i = 0; i < arguments.length; ++i) {
    switch (arguments[i]) {
    case X:
      words.push("X" + xyzFormat.format(_xHome));
      xOutput.reset();
      break;
    case Y:
      words.push("Y" + xyzFormat.format(_yHome));
      yOutput.reset();
      break;
    case Z:
      if (getProperty("useM140")) {
        validate((arguments.length <= 1), "Retracts for the Z-axis have to be specified separately by using the useM140 property.");
        writeBlock("L " + mFormat.format(140) + " MB MAX");
        zOutput.reset();
        retracted = true;
        return;
      } else {
        words.push("Z" + xyzFormat.format(_zHome));
        zOutput.reset();
        retracted = true;
        break;
      }
    default:
      error(localize("Unsupported axis specified for writeRetract()."));
      return;
    }
  }
  if (words.length > 0) {
    switch (method) {
    case "M91":
    case "M92":
      writeBlock("L " + words.join(getWordSeparator()) + SP + "R0 FMAX " + mFormat.format(method == "M92" ? 92 : 91));
      break;
    default:
      error(localize("Unsupported safe position method."));
      return;
    }
  }
}

function onPassThrough(text) {
  var commands = String(text).split(",");
  for (text in commands) {
    writeBlock(commands[text]);
  }
}

function onClose() {
  optionalSection = false;

  setTolerance(0);
  setCoolant(COOLANT_OFF);

  // if (getNumberOfSections() > 0) {
  //   onCommand(COMMAND_BREAK_CONTROL);
  // }

  onCommand(COMMAND_STOP_SPINDLE);

  /*
  if (useCycl247) {
    writeBlock(
      "CYCL DEF 247 " + localize("DATUM SETTING") + " ~" + EOL +
      "  Q339=" + 0 + " ; " + localize("DATUM NUMBER")
    );
  } else {
    //writeBlock("CYCL DEF 7.0 " + localize("DATUM SHIFT"));
    //writeBlock("CYCL DEF 7.1 #" + 0);
  }
*/
  onCommand(COMMAND_UNLOCK_MULTI_AXIS);

  writeRetract(Z);

  if (getProperty("useParkPosition")) {
    writeRetract(X, Y);
  }

  if (machineConfiguration.isMultiAxisConfiguration()) {
    // simple retract
    writeBlock(
      "L" +
      conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(0)) +
      conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(0)) +
      conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(0)) +
      " FMAX " + mFormat.format(94)
    );
  }

  setWorkPlane(new Vector(0, 0, 0), true, false); // reset working plane - just turn again

  if (forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) {
    writeBlock(mFormat.format(127)); // cancel shortest path traverse
  }

  onCommand(COMMAND_STOP_CHIP_TRANSPORT);
  
  // open machine door
  writeBlock(mFormat.format(31));
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off

  if (typeof inspectionProgramEnd == "function") {
    inspectionProgramEnd();
  }

  if (subprograms.length > 0) {
    write(subprograms);
  }

  writeBlock(
    "END PGM" + (programName ? (SP + programName) : "") + ((unit == MM) ? " MM" : " INCH")
  );
}

function setProperty(property, value) {
  properties[property].current = value;
}
