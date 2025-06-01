# FinAnalyzerAI

🧠 Финансовый анализ PDF-отчетности с помощью AI и расчётов на Python.  
📊 Ввод: PDF с 1 и 2 формами отчётности.  
📈 Вывод: автоматический расчёт показателей (EBITDA, Net Debt/EBITDA и др.).

## 🚀 Стек технологий
- Ruby on Rails — веб-интерфейс и API
- Python — расчёты и обработка PDF
- PyTorch + transformers — ML для извлечения данных
- Docker — контейнеризация
- Pandas, openpyxl — для Excel и расчётов
- Ollama - ML модели

## 📦 Установка

```bash
git clone https://github.com/cyberriver/FinAnalyzerAI.git
cd FinAnalyzerAI
cp .

для установки Ollama
curl -fsSL https://ollama.com/install.sh | sh

используется модель Llama3