from flask import Flask, jsonify
import os
import sys


# 12-Factor: configuración vía variables de entorno (sin valores codificados)
PORT = int(os.environ.get("PORT", "8080"))
MESSAGE = os.environ.get("MESSAGE", "Hola")
RELEASE = os.environ.get("RELEASE", "v0")

app = Flask(__name__)

@app.route("/")
def root():
    # Registrar logs en stdout (12-Factor: logs como flujos de eventos)
    print(f"[INFO] GET /  message={MESSAGE} release={RELEASE}", file=sys.stdout, flush=True)
    return jsonify(
        status="ok",
        message=MESSAGE,
        release=RELEASE,
        port=PORT,
    )


@app.route("/readyz")
def readyz():
    try:
        return {"status": "ok"}, 200
    except:
        return {"status": "unavailable"}, 503

@app.route("/livez")
def livez():
    return {"status": "alive"}, 200

if __name__ == "__main__":
    # 12-Factor: vincular a un puerto; proceso único; sin estado
    app.run(host="127.0.0.1", port=PORT)
