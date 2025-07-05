import os
import plyvel
from flask import Flask, request, jsonify

app = Flask(__name__)
db_path = os.getenv("LEVELDB_PATH", "/data/leveldb")
mode = os.getenv("LEVELDB_MODE", "ro")  # default to read-only

os.makedirs(db_path, exist_ok=True)

try:
    db = plyvel.DB(
        db_path,
        create_if_missing=(mode == "rw"),
        read_only=(mode != "rw")
    )
except Exception as e:
    app.logger.error(f"Failed to open DB in {mode} mode: {e}")
    raise e

@app.route("/")
def index():
    key = request.args.get("key")
    val = request.args.get("val")

    if key and val:
        if mode != "rw":
            return jsonify({"error": "Write not allowed on read-only replica"}), 403
        db.put(key.encode(), val.encode())
        return jsonify({"message": f"Stored key={key}, val={val}"})

    if key:
        value = db.get(key.encode())
        if value:
            return jsonify({"key": key, "value": value.decode()})
        return jsonify({"error": "Key not found"}), 404

    return jsonify({"message": f"Service is up in {mode} mode"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
