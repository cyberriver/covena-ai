from flask import Flask, request, jsonify
from metrics import calculate_metrics

app = Flask(__name__)

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
    app.run(host='0.0.0.0', port=5001)
