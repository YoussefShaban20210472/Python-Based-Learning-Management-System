import re


def create_procedure(raw_procedure):
    procedure_name = raw_procedure[0]
    function_name = raw_procedure[0].split(".")[1]
    params = []

    for index, name in enumerate(raw_procedure):
        if len(name) > 0 and name[0] == "@":
            if raw_procedure[index + 2].lower() != "output":
                params.append(name[1:])
    return {function_name: {"procedure_name": procedure_name, "params": tuple(params)}}


file_path = "1.sql"
pattern = r"create +proc +((?:(?!\n *as)[\s\S])+)\n *as"

# Read the file content
with open(file_path, "r", encoding="utf-8") as f:
    text = f.read()

# Find all matches
matches = re.findall(pattern, text, re.MULTILINE | re.DOTALL)
raw_procedures = []
# Show results
if matches:

    for i, match in enumerate(matches, 1):
        raw_procedures.append(re.split(r"[ \n,]+", match))

else:
    print("\nNo matches found.")

procedures = {}

for raw_procedure in raw_procedures:
    procedure = create_procedure(raw_procedure)
    procedures.update(procedure)


with open("stored_procedures.py", "w", encoding="utf-8") as f:
    f.write(f"stored_procedures = {procedures!r}")
