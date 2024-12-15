const fs = require("fs");

let [originalMap, moveCommands] = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n\n");
originalMap = originalMap.split("\n").map((line) => line.split(""));
moveCommands = moveCommands.split("\n").join("").split("");

const DIRECTIONS = {
  ">": [1, 0],
  "<": [-1, 0],
  "^": [0, -1],
  v: [0, 1],
};

const OBJECT_TYPES = {
  ROBOT: 0,
  BOX: 1,
};

const calculateScore = (entities) =>
  entities
    .filter((entity) => entity.type === OBJECT_TYPES.BOX)
    .reduce(
      (total, entity) => total + entity.position[1] * 100 + entity.position[0],
      0,
    );

const areVectorsEqual = (vecA, vecB) =>
  vecA.length === vecB.length &&
  vecA.every((value, index) => value === vecB[index]);

const addVectors = (vecA, vecB) =>
  vecA.map((value, index) => value + vecB[index]);

const getMapValue = (position) => gameMap[position[1]][position[0]];

const getRobot = () =>
  entities.find((entity) => entity.type === OBJECT_TYPES.ROBOT);

let entities = [];

let gameMap = originalMap.map((row) => {
  let expandedRow = [];
  row.forEach((cell) => {
    for (let i = 0; i < 2; i++) {
      expandedRow.push(cell === "#" ? "#" : ".");
    }
  });
  return expandedRow;
});

// Function to move an entity in a specified direction
const moveEntity = (directionKey, entity) => {
  const direction = DIRECTIONS[directionKey];
  const newPosition = entity.position.map(
    (coord, idx) => coord + direction[idx],
  );
  const secondaryPosition = addVectors(
    newPosition,
    addVectors(entity.size, [-1, -1]),
  );

  // Check for wall collisions
  if (
    getMapValue(newPosition) === "#" ||
    getMapValue(secondaryPosition) === "#"
  ) {
    return false;
  }

  // Detect collisions with other entities
  const obstacles = entities.filter((other) => {
    if (areVectorsEqual(other.position, entity.position)) return false;
    return (
      areVectorsEqual(other.position, newPosition) ||
      areVectorsEqual(other.position, secondaryPosition) ||
      areVectorsEqual(addVectors(other.position, [1, 0]), newPosition)
    );
  });

  // Attempt to move obstacles if possible
  if (
    obstacles.length === 0 ||
    obstacles.every((obstacle) => moveEntity(directionKey, obstacle))
  ) {
    entity.position = newPosition;
    return true;
  } else {
    return false;
  }
};

originalMap.forEach((row, y) =>
  row.forEach((cell, x) => {
    if (["#", "."].includes(cell)) return;

    entities.push({
      position: [x * 2, y],
      type: cell === "@" ? OBJECT_TYPES.ROBOT : OBJECT_TYPES.BOX,
      size: cell === "@" ? [1, 1] : [2, 1],
    });

    // Replace the entity symbol with empty space in the map
    originalMap[y][x] = ".";
  }),
);

moveCommands.forEach((directionKey) => {
  const previousState = entities.map((entity) => ({
    position: [...entity.position],
    size: [...entity.size],
    type: entity.type,
  }));

  // Attempt to move the robot
  if (!moveEntity(directionKey, getRobot())) {
    entities = previousState;
  }
});

console.log(calculateScore(entities));
