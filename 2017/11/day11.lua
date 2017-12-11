file = io.open("input.txt", "r");
input = file:read("*a");
input_test = "se,sw,se,sw,sw";

x = 0; y = 0; z = 0;
furthest = 0;

map = {
  n = { 1, 0, -1 },
  ne = { 1, -1, 0 },
  se = { 0, -1, 1 },
  s = { -1, 0, 1 },
  sw = { -1, 1, 0 },
  nw = { 0, 1, -1 }
};

local function dist(x, y, z)
  return (math.abs(x) + math.abs(y) + math.abs(z)) / 2;
end

for dir in input:gmatch("%w+") do
  x = x + map[dir][1]
  y = y + map[dir][2]
  z = z + map[dir][3]

  current_distance = dist(x, y, z);
  if current_distance > furthest then furthest = current_distance end
end

distance = dist(x, y, z);

print("pt1", distance, "pt2", furthest)