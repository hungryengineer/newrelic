from flask import Flask, request, jsonify
import logging
import random
import time


app = Flask(__name__)

# Structured JSON logging
logger = logging.getLogger("app_logger")
handler = logging.StreamHandler()
formatter = logging.Formatter('{"time": "%(asctime)s", "level": "%(levelname)s", "message": "%(message)s"}')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.INFO)

@app.route('/')
def home():
    logger.info("Home endpoint hit")
    return "Hello from Flask + New Relic!", 200

@app.route('/compute')
def compute():
    logger.info("Compute endpoint hit")
    time.sleep(random.uniform(0.1, 0.5))
    result = sum([i*i for i in range(1000)])
    logger.info(f"Computation result: {result}")
    return jsonify({"result": result})

@app.route('/error')
def error():
    logger.warning("Error endpoint triggered")
    raise Exception("This is a simulated error for APM/log testing.")

@app.errorhandler(Exception)
def handle_exception(e):
    logger.error(f"Unhandled exception: {str(e)}")
    return jsonify(error=str(e)), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
