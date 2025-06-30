import re

with open("merkle/8nodes_128txpb_16rounds_MERKLE.txt") as f:
    content = f.read()

# Print lines with TPS to confirm we're matching the right one
for line in content.splitlines():
    if "TPS" in line:
        print("📄 Found line:", repr(line))

# Strict regex: match line that starts with 'Average TPS' and ends with the correct number
match = re.search(r"Average TPS across \d+ nodes\s+\(Tx/Round: \d+, Rounds: \d+\):\s*([\d.]+)", content)
if match:
    print("✅ Extracted TPS:", match.group(1))
else:
    print("❌ No match found")
