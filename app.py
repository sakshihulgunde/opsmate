from flask import Flask
import os
import psycopg2

app = Flask(__name__)


def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "database"),
        port=int(os.getenv("DB_PORT", "5432")),
        dbname=os.getenv("DB_NAME", "opsmate"),
        user=os.getenv("DB_USER", "opsmate"),
        password=os.getenv("DB_PASSWORD", "opsmatepass"),
        connect_timeout=5
    )


@app.route("/")
def home():
    return "OpsMate Service v2 is running successfully!"


@app.route("/health")
def health():
    return "OpsMate Health: OK"


@app.route("/db-test")
def db_test():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT 1;")
        result = cursor.fetchone()[0]

        cursor.close()
        conn.close()

        return f"Database connectivity: OK (result={result})"

    except Exception as e:
        return f"Database connectivity: FAILED - {e}", 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
