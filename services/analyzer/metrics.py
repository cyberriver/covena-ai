import pandas as pd

def calculate_metrics(file1, file2, metrics):
    # Пример: читаем Excel файлы
    df1 = pd.read_excel(file1)
    df2 = pd.read_excel(file2)

    # Пример: dummy логика
    results = []
    for metric in metrics:
        if metric == 'EBITDA':
            value = 1000000  # заглушка
            explanation = "Считается как OIBDA + амортизация"
        elif metric == 'DEBT/EBITDA':
            value = 3.2
            explanation = "Считается как Общий долг / EBITDA"
        else:
            value = None
            explanation = "Метрика не реализована"

        results.append({
            'metric': metric,
            'value': value,
            'explanation': explanation
        })

    return results
