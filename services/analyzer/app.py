from flask import Flask, request, jsonify
from metrics import calculate_metrics

app = Flask(__name__)

@app.route("/chat", methods=["POST"])
def chat():
    prompt = request.json.get("prompt", "")
    
    # Упрощённый ответ (позже можно подключить OpenAI, LLaMA, ML-модель)
    if "EBITDA" in prompt.upper():
        reply = "EBITDA = Операционная прибыль + Амортизация."
    else:
        reply = "Пожалуйста, уточните вопрос или загрузите PDF."

    return jsonify({"reply": reply})

@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({"status": "ok"})

@app.route("/health", methods=["GET"])
def health():
    try:
        test = requests.post("http://ollama:11434/api/generate", json={
            "model": "llama3",
            "prompt": "ping",
            "stream": False
        }, timeout=3)
        if test.ok:
            return jsonify({"llama3": "online"})
    except Exception as e:
        return jsonify({"llama3": "unreachable", "error": str(e)}), 503

    return jsonify({"llama3": "error"}), 500

@app.route('/analyze', methods=['POST'])
def analyze():
    file1 = request.files.get('form1')
    file2 = request.files.get('form2')
    metrics = request.form.getlist('metrics')

    if not file1 or not file2:
        return jsonify({'error': 'Missing input files'}), 400

    results = calculate_metrics(file1, file2, metrics)
    return jsonify(results)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
